//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//

#define PUSH_DEVICE_ID @"PUSH_DEVICE_ID"
#import <Foundation/Foundation.h>
#import "BaasioMessage.h"

@interface BaasioPush : NSObject
- (void)sendPushInBackground:(BaasioMessage *)config
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

- (void)unregisterInBackground:(void (^)(void))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock;

- (void)registerInBackground:(NSString *)deviceID
                            tags:(NSArray *)tags
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

@end