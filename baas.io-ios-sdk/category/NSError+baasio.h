//
//  NSError+baasio.h
//  NSError
//
//  Created by cetauri on 13. 1. 22..
//  Copyright (c) 2013년 Baas.io. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *_uuid;
@interface NSError (Baasio)
-(void)setUuid:(NSString *)uuid;
- (NSString *)uuid;

@end
