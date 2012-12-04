//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Baasio : NSObject
@property(nonatomic, strong) NSString *apiURL;
@property(nonatomic, strong) NSString *applicationName;
@property(nonatomic, strong) NSString *baasioID;

/**
 sharedInstance
 */
+ (id)sharedInstance;
/**
 setApplicationInfo
 @param orgName orgName
 @param applicationName applicationName
 */
+ (void)setApplicationInfo:(NSString *)baasioID applicationName:(NSString *)applicationName;
/**
 setApplicationInfo
 @param apiURL apiURL
 @param orgName orgName
 @param applicationName applicationName
 */
+ (void)setApplicationInfo:(NSString *)apiURL baasioID:(NSString *)baasioID applicationName:(NSString *)applicationName;

/** getAPIURL */
- (NSURL *)getAPIURL;
@end


