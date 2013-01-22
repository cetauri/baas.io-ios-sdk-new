//
//  BaasioNetworkManager.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 12..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "BaasioNetworkManager.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "Baasio+Private.h"
#import "NetworkActivityIndicatorManager.h"

@implementation BaasioNetworkManager

+(BaasioNetworkManager *)sharedInstance
{
    static BaasioNetworkManager  *_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _manager = [[BaasioNetworkManager alloc] init];
    });
    return _manager;
}

- (id)connectWithHTTPSync:(NSString *)path
               withMethod:(NSString *)httpMethod
                   params:(NSDictionary *)params
                    error:(NSError **)error
{
    __block id response = nil;
    __block BOOL isFinish = false;
    __block NSError *blockError = nil;
    
    BaasioRequest *request = [self connectWithHTTP:path
               withMethod:httpMethod
                   params:params
                  success:^(id result){
                      response = result;
                      isFinish = true;
                  }
                  failure:^(NSError *error){
                      blockError = error;
                      isFinish = true;
                  }];
    
    [request waitUntilFinished];
    
#ifndef UNIT_TEST
    while(!isFinish){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
#endif

     if (error != nil) {
         *error = blockError;
     }
    return response;
}

- (BaasioRequest*) connectWithHTTP:(NSString*)path
                      withMethod:(NSString*)httpMethod
                        params:(NSDictionary*)params
                         success:(void (^)(id result))successBlock
                         failure:(void (^)(NSError *error))failureBlock {
    
    
    NSDictionary *parameters;
    if ([httpMethod isEqualToString:@"GET"] ||[httpMethod isEqualToString:@"DELETE"]) {
        parameters = params;
    }
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:httpMethod path:path parameters:parameters];
    request = [[Baasio sharedInstance] setAuthorization:request];

    if ([httpMethod isEqualToString:@"POST"] || [httpMethod isEqualToString:@"PUT"]) {
        NSError *error;
        NSData *data = [params JSONDataWithOptions:JKSerializeOptionNone error:&error];
        if (error != nil) {
            failureBlock(error);
            return nil;
        }
        request.HTTPBody = data;
    }
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [self failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            [[NetworkActivityIndicatorManager sharedInstance] hide];
                                                                                            successBlock(JSON);
                                                                                        }
                                                                                        failure:failure];
    [operation start];
    [[NetworkActivityIndicatorManager sharedInstance] show];
    return (BaasioRequest*)operation;

}

#pragma mark - API response method
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock {
    
    
    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        
        [[NetworkActivityIndicatorManager sharedInstance] hide];
        
        NSError *e = [self extractNormalError:error JSON:JSON];
        failureBlock(e);
    };
    return failure;
}

- (NSError *)extractNormalError:(NSError *)error JSON:(id)JSON{

    if (JSON == nil){
        NSString *debugDescription = error.userInfo[@"NSDebugDescription"];
        if (debugDescription != nil) {
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:debugDescription forKey:NSLocalizedDescriptionKey];

            NSError *e = [NSError errorWithDomain:error.domain code:error.code userInfo:details];
            return e;
        }
        return error;
    }

    NSString *message = [NSString stringWithFormat:@"%@ (uuid : %@)", JSON[@"error_description"], JSON[@"error_uuid"]];
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:message forKey:NSLocalizedDescriptionKey];
    
    int error_code = [JSON[@"error_code"] intValue];
    
    NSError *e = [NSError errorWithDomain:@"BassioError" code:error_code userInfo:details];

    return e;
}
@end
