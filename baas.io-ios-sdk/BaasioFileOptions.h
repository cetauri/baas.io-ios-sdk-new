//
//  BaasioFileOptions.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 11..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    BaasioFileOptions
*/
@interface BaasioFileOptions : NSObject

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
@property(strong) NSString *cacheControl;

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1
@property(strong) NSString *contentDisposition;

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11
@property(strong) NSString *contentEncoding;

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17
@property(strong) NSString *contenttype;

//http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13
@property(strong) NSString *contentLength;

-(NSDictionary*)dictionary;
@end
