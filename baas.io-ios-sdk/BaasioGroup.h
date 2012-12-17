//
//  BaasioGroup.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 11..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baasio+Private.h"
#import "BaasioUser.h"

@interface BaasioGroup : BaasioEntity
//
//@property(strong) NSString *name;
//@property(strong) NSString *path;

- (void)setGroupName:(NSString*)group;
- (void)setUserName:(NSString*)user;
//- (BaasioEntity *)save:(NSError **)error;

- (BaasioRequest*)createInBackground:(void (^)(BaasioGroup *group))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock;


//- (BaasioEntity *)update:(NSError **)error;

- (BaasioRequest*)updateInBackground:(void (^)(BaasioGroup *group))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;


//- (void)delete:(NSError **)error;
- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;

//XXX : join, withdraw
//- (void)add:(NSError **)error;
- (BaasioRequest*)addInBackground:(void (^)(BaasioGroup *group))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;
//- (void)remove:(NSError **)error;
- (BaasioRequest*)removeInBackground:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;
@end
