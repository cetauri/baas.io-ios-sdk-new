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

- (void)signIn:(NSError**)error {
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : self.username,
                                @"password" : self.password
                            };

    [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:@"token" withMethod:@"POST" params:params error:error];
    return;
}

- (BaasioRequest*)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : self.username,
                                @"password" : self.password
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

- (void)signUp:(NSError**)error
{
    NSDictionary *params = @{
                                @"name":[self objectForKey:@"name"],
                                @"password":self.password,
                                @"username":self.username,
                                @"email":self.email
                            };

    [[BaasioNetworkManager sharedInstance] connectWithHTTPSync:@"users" withMethod:@"POST" params:params error:error];
    return;
}


- (BaasioRequest*)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"name":[self objectForKey:@"name"],
                                @"password":self.password,
                                @"username":self.username,
                                @"email":self.email
                            };

    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:@"users"
                                                    withMethod:@"POST"
                                                        params:params
                                                       success:^(id result){
                                                           successBlock();
                                                       }
                                                       failure:failureBlock];
}

#pragma mark - etc
-(NSString*)username{
    return [self objectForKey:@"username"];
}

-(NSString*)email{
    return [self objectForKey:@"email"];
}

-(NSString*)password{
    return [self objectForKey:@"password"];
}
-(NSString*)name{
    return [self objectForKey:@"name"];
}
-(void)setUsername:(NSString*)username{
    [self setObject:username forKey:@"username"];
}

-(void)setEmail:(NSString*)email{
    [self setObject:email forKey:@"email"];
}

-(void)setPassword:(NSString*)password{
    [self setObject:password forKey:@"password"];
}
-(void)setName:(NSString*)name{
    [self setObject:name forKey:@"name"];
}

@end