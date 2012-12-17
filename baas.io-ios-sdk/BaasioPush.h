//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//

#define PUSH_DEVICE_ID @"PUSH_DEVICE_ID_BAASIO_SDK"
#import <Foundation/Foundation.h>
#import "BaasioMessage.h"
#import "BaasioRequest.h"

@interface BaasioPush : NSObject
//- (void)sendPush:(NSError**)error;
- (BaasioRequest*)sendPushInBackground:(BaasioMessage *)config
                          successBlock:(void (^)(void))successBlock
                          failureBlock:(void (^)(NSError *error))failureBlock;

//- (void)unregister:(NSError**)error;
- (BaasioRequest*)unregisterInBackground:(void (^)(void))successBlock
                            failureBlock:(void (^)(NSError *error))failureBlock;

//- (void)register:(NSError**)error;
- (BaasioRequest*)registerInBackground:(NSString *)deviceID
                                  tags:(NSArray *)tags
                          successBlock:(void (^)(void))successBlock
                          failureBlock:(void (^)(NSError *error))failureBlock;
@end