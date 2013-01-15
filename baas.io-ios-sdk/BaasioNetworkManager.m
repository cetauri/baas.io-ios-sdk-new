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
     NSDictionary *parameters;
     if ([httpMethod isEqualToString:@"GET"] ||[httpMethod isEqualToString:@"DELETE"]) {
         parameters = params;
     }
     
     NSURL *url = [[Baasio sharedInstance] getAPIURL];
     AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

     NSMutableURLRequest *request = [httpClient requestWithMethod:httpMethod path:path parameters:parameters];
     request = [[Baasio sharedInstance] setAuthorization:request];
     
     if ([httpMethod isEqualToString:@"POST"] || [httpMethod isEqualToString:@"PUT"]) {
         NSError *error;
         NSData *data = [params JSONDataWithOptions:JKSerializeOptionNone error:&error];
         if (error != nil) {
             return error;
         }
         request.HTTPBody = data;
     }

     __block BOOL isFinish = false;
     __block NSError *blockError = nil;

     id response = nil;
     AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                             response = JSON;
                                                                                             isFinish = true;
                                                                                             [[NetworkActivityIndicatorManager sharedInstance] hide];
                                                                                         }
                                                                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *_error, id JSON){
                                                                                             blockError = [self extractNormalError:_error JSON:JSON];
                                                                                             isFinish = true;
                                                                                             [[NetworkActivityIndicatorManager sharedInstance] hide];
                                                                                         }];
     
     [[NetworkActivityIndicatorManager sharedInstance] show];

     NSOperationQueue *queue = [[NSOperationQueue alloc]init];
     [queue addOperation:operation];
     [operation waitUntilFinished];

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
    
    [[NetworkActivityIndicatorManager sharedInstance] hide];
    
    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
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

    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:JSON[@"error_description"] forKey:NSLocalizedDescriptionKey];

    NSString *domain = JSON[@"error"];
    return [NSError errorWithDomain:domain code:error.code userInfo:details];
}
@end
