//
//  Baasio+Private.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 3..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Baasio(Private)
+ (id)sharedInstance;
- (void)setToken:(NSString*)token;
- (NSMutableURLRequest *)setAuthorization:(NSMutableURLRequest *)request;
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success:(void (^)(NSDictionary *response))successBlock;
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, id))successWithVoid:(void (^)(void))successBlock;
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock;
@end