//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BaasioPush : NSObject
- (void)sendPush:(id)config;

- (void)unregisterDevice:(NSString *)deviceID;

- (void)registerDevice:(NSString *)uuid;
@end