//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BaasioPushConfig.h"

@interface BaasioPush : NSObject
- (void)sendPushInBackground:(BaasioPushConfig *)config
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

- (void)unregisterInBackground:(NSString *)uuid
                  successBlock:(void (^)(void))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock;

- (void)registerInBackground:(NSString *)deviceID
                            tags:(NSArray *)tags
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

//TODO :
//updateInBackground
@end