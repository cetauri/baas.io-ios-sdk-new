//
//  BaasioFileOptions.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 11..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "BaasioFileOptions.h"

@implementation BaasioFileOptions


-(NSDictionary*)dictionary{
    NSMutableDictionary *_dictionary = [[NSMutableDictionary alloc]init];
    if(_cacheControl != nil){
        [_dictionary setObject:_cacheControl forKey:@"Cache-Control"];
    }
    
    if(_contentDisposition != nil){
        [_dictionary setObject:_contentDisposition forKey:@"Content-Disposition"];
    }
    
    if(_contentEncoding != nil){
        [_dictionary setObject:_contentEncoding forKey:@"Content-Encoding"];
    }
    
    if(_contenttype != nil){
        [_dictionary setObject:_contenttype forKey:@"Content-type"];
    }
    
    if(_contentLength != nil){
        [_dictionary setObject:_contentLength forKey:@"Content-Length"];
    }

    return [NSDictionary dictionaryWithDictionary:_dictionary];
}
@end
