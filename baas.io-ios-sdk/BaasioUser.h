//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
@interface BaasioUser : BaasioEntity


@property(strong) NSString *username;
@property(strong) NSString *email;
@property(strong) NSString *password;
@property(strong) NSString *name;

+ (BaasioUser *)user;
+ (BaasioUser *)currtuser;
+ (void)signOut;


//- (void)signIn;
- (void)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;
//- (void)signUp:(void (^)(void))successBlock
//  failureBlock:(void (^)(NSError *error))failureBlock;
//- (void)signUp;
- (void)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;
- (void)unsubscribeInBackground:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;
@end
