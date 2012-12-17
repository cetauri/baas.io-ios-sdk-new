//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
#import "BaasioRequest.h"

@interface BaasioUser : BaasioEntity


@property(strong) NSString *username;
@property(strong) NSString *email;
@property(strong) NSString *password;
@property(strong) NSString *name;

+ (BaasioUser *)user;
+ (BaasioUser *)currtuser;
+ (void)signOut;


- (void)signIn:(NSError**)error;
- (BaasioRequest*)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;

//- (void)signUp:(NSError**)error;;
- (BaasioRequest*)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;

//- (void)unsubscribe:(NSError**)error;;

- (BaasioRequest*)unsubscribeInBackground:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;
@end
