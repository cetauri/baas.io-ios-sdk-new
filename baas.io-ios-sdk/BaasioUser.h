//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
#import "BaasioRequest.h"

/**
 A bass.io Framework User Object.
*/
@interface BaasioUser : BaasioEntity

@property(strong) NSString *username;
@property(strong) NSString *email;
@property(strong) NSString *password;
@property(strong) NSString *name;

/**
 user
 */
+ (BaasioUser *)user;

/**
 currentUser
 */
+ (BaasioUser *)currentUser;

/**
 signOut
 */
+ (void)signOut;


/**
 signIn
 @param error error
 */
- (void)signIn:(NSError**)error;

/**
 sign asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;

/**
 signUp
 @param error error
 */
- (void)signUp:(NSError**)error;

/**
 signUp asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


/**
 unsubscribe
 @param error error
 */
- (void)unsubscribe:(NSError**)error;
/**
 unsubscribe asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)unsubscribeInBackground:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;
@end
