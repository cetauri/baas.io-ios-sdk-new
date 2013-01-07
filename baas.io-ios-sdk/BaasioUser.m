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

+ (BaasioUser *)currtuser{
    BaasioUser *user =  [[Baasio sharedInstance]currentUser];
    return user;
}


+ (void)signOut {
    [[Baasio sharedInstance] setCurrentUser:nil];
    [[Baasio sharedInstance] setToken:nil];
}


//- (void)signIn:(NSError**)error {
//
//    NSDictionary *params = @{
//        @"name":[self objectForKey:@"name"],
//        @"password":self.password,
//        @"username":self.username,
//        @"email":self.email
//    };
//    
//    NSURL *url = [[Baasio sharedInstance] getAPIURL];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"users" parameters:nil];
//    NSData *data = [params JSONDataWithOptions:JKSerializeOptionNone error:error];
//    if (error != nil) {
//        return;
//    }
//    request.HTTPBody = data;
//    
//    __block BOOL isFinish = false;
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
//                                                                                            isFinish = true;
//                                                                                        }
//                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *_error, id JSON){
//                                                                                            *error = _error;
//                                                                                            isFinish = true;
//                                                                                        }];
//    [operation start];
//    
//#ifndef UNIT_TEST
//    while(!isFinish){
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//#endif
//    return;
//}


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