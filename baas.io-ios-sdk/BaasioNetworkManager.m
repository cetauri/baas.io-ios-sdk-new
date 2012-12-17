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
                                                                                            successBlock(JSON);
                                                                                        }
                                                                                        failure:failure];
    [operation start];
    return (BaasioRequest*)operation;

}
#pragma mark - API response method
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock {
    
    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        if (JSON == nil){
            failureBlock(error);
            return;
        }
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:JSON[@"error_description"] forKey:NSLocalizedDescriptionKey];
        
        NSString *domain = JSON[@"error"];
        NSError *e = [NSError errorWithDomain:domain code:error.code userInfo:details];
        
        failureBlock(e);
    };
    return failure;
}

@end
