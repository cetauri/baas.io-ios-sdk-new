//
//  BaasioNetworkManager.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 12..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "BaasioRequest.h"

@interface BaasioNetworkManager : NSObject
+ (BaasioNetworkManager *)sharedInstance;


- (id)connectWithHTTPSync:(NSString *)path
               withMethod:(NSString *)method
                   params:(NSDictionary *)params
                    error:(NSError **)error;

- (BaasioRequest*) connectWithHTTP:(NSString*)path
                        withMethod:(NSString*)httpMethod
                            params:(NSDictionary*)params
                           success:(void (^)(id result))successBlock
                           failure:(void (^)(NSError *error))failureBlock;

#pragma mark - API response method
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock;

@end
