//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioUser.h"


@implementation BaasioUser {

}
@synthesize username = _username;
@synthesize email = _email;
@synthesize password = _password;
@synthesize name = _name;


+ (BaasioUser *)user {
 return nil;
}

- (void)signIn {

}
- (void)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{

}
+ (BaasioUser *)currtuser {
 return nil;
}


+ (BaasioUser *)signOut {
 return nil;
}

- (void)signUp {

}

- (void)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{

}
@end