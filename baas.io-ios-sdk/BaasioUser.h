//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BaasioUser : NSObject

@property(strong) NSString *username;
@property(strong) NSString *email;
@property(strong) NSString *password;
@property(strong) NSString *name;


+ (BaasioUser *)user;

//+ (BaasioUser *)currtuser;

+ (BaasioUser *)signOut;


- (void)signIn;
- (void)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;

- (void)signUp;
- (void)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;
- (void)unsubscribeInBackground:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;
@end
