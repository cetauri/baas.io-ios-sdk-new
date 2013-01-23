//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "BaasioUser.h"
#import "Baasio.h"
#import "Baasio+Private.h"
#import "BaasioNetworkManager.h"
@implementation BaasioUser 

+ (BaasioUser *)user
{
    return [[BaasioUser alloc] init];
}

+ (BaasioUser *)currentUser {
    BaasioUser *user =  [[Baasio sharedInstance]currentUser];
    return user;
}

+ (void)signOut {
    [[Baasio sharedInstance] setCurrentUser:nil];
    [[Baasio sharedInstance] setToken:nil];
}

- (void)unsubscribe:(NSError**)error
{
    NSString *path = [@"users/" stringByAppendingString:self.username];
    [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:path withMethod:@"DELETE" params:nil error:error];
    return;
}

- (BaasioRequest*)unsubscribeInBackground:(void (^)(void))successBlock
                             failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [@"users/" stringByAppendingString:self.username];
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                    withMethod:@"DELETE"
                                                        params:nil
                                                       success:^(id result){
                                                           successBlock();
                                                        }
                                                       failure:failureBlock];
}

+ (void)signIn:(NSString *)username
      password:(NSString *)password
         error:(NSError**)error
{
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : username,
                                @"password" : password
                            };

    id result = [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:@"token"
                                                                withMethod:@"POST"
                                                                    params:params
                                                                     error:error];
    
    NSDictionary *response = (NSDictionary *)result;
    Baasio *baasio = [Baasio sharedInstance];
    NSString *access_token = response[@"access_token"];
    [baasio setToken:access_token];
    
    NSDictionary *userReponse = response[@"user"];
    BaasioUser *loginUser = [BaasioUser user];
    [loginUser setEntity:userReponse];
    [baasio setCurrentUser:loginUser];
    
    
    return;
}

+ (BaasioRequest*)signInBackground:(NSString *)username
                          password:(NSString *)password
                      successBlock:(void (^)(void))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : username,
                                @"password" : password
                            };
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:@"token"
                                                    withMethod:@"POST"
                                                        params:params
                                                       success:^(id result){
                                                           NSDictionary *response = (NSDictionary *)result;
                                                           Baasio *baasio = [Baasio sharedInstance];
                                                           NSString *access_token = response[@"access_token"];
                                                           [baasio setToken:access_token];
                                                           
                                                           NSDictionary *userReponse = response[@"user"];
                                                           BaasioUser *loginUser = [BaasioUser user];
                                                           [loginUser setEntity:userReponse];
                                                           [baasio setCurrentUser:loginUser];
                                                           
                                                           successBlock();
                                                       }
                                                       failure:failureBlock];
}

+ (void)signUp:(NSString *)username
      password:(NSString *)password
          name:(NSString *)name
         email:(NSString *)email
         error:(NSError**)error
{
    NSDictionary *params = @{
                                @"name":name,
                                @"password":password,
                                @"username":username,
                                @"email":email
                            };

    [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:@"users" withMethod:@"POST" params:params error:error];
    return;
}


+ (BaasioRequest*)signUpInBackground:(NSString *)username
                            password:(NSString *)password
                                name:(NSString *)name
                               email:(NSString *)email
                        successBlock:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"name":name,
                                @"password":password,
                                @"username":username,
                                @"email":email
                            };

    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:@"users"
                                                    withMethod:@"POST"
                                                        params:params
                                                       success:^(id result){
                                                           successBlock();
                                                       }
                                                       failure:failureBlock];
}


+ (void)signUpViaFacebook:(NSString *)accessToken
                    error:(NSError**)error
{
    NSDictionary *params = @{
                                @"fb_access_token" : accessToken
                            };

    NSString *path = @"auth/facebook";
    [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:path
                                                    withMethod:@"GET"
                                                        params:params
                                                         error:error];
}

+ (BaasioRequest*)signUpViaFacebookInBackground:(NSString *)accessToken
                                          error:(void (^)(void))successBlock
                                   failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"fb_access_token" : accessToken
                            };

    NSString *path = @"auth/facebook";
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                    withMethod:@"GET"
                                                        params:params
                                                       success:^(id result){
                                                           successBlock();
                                                       }
                                                       failure:failureBlock];
}


+ (void)signInViaFacebook:(NSString *)accessToken
                    error:(NSError**)error
{
    [self signUpViaFacebook:accessToken error:error];
}

+ (BaasioRequest*)signInViaFacebookInBackground:(NSString *)accessToken
                                          error:(void (^)(void))successBlock
                                   failureBlock:(void (^)(NSError *error))failureBlock
{
    return [self signUpViaFacebookInBackground:accessToken
                                  error:successBlock
                           failureBlock:failureBlock];
}


#pragma mark - etc
-(NSString*)username{
    return [self objectForKey:@"username"];
}

-(void)setUsername:(NSString*)username{
    [self setObject:username forKey:@"username"];
}
@end