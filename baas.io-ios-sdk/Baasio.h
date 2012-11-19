//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
//#import "JSONKit.h"
#import "BaasioEntity.h"
#import "BaasioQuery.h"
#import "BaasioUser.h"

@interface Baasio : NSObject
/**
 setApplicationInfo
 @param orgName orgName
 @param applicationName applicationName
 */
+ (void)setApplicationInfo:(NSString *)orgName applicationName:(NSString *)applicationName;
/**
 setApplicationInfo
 @param apiURL apiURL
 @param orgName orgName
 @param applicationName applicationName
 */
+ (void)setApplicationInfo:(NSString *)apiURL organizationName:(NSString *)orgName applicationName:(NSString *)applicationName;
/** createInstance */
+ (id) createInstance;
/** getAppInfo */
- (NSString *)getAppInfo;
/** getAPIURL */
- (NSString *)getAPIURL;
/** getAPIHost */
- (NSString *)getAPIHost;
@end