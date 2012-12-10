//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioUser.h"
#import "Baasio.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "Baasio+Private.h"
@implementation BaasioUser 

+ (BaasioUser *)user
{
    return [[BaasioUser alloc] init];
}


- (void)unsubscribeInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [@"users/" stringByAppendingString:self.username];
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];

    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:failure];
    [operation start];
}


- (void)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : self.username,
                                @"password" : self.password
                            };
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"token" parameters:params];

    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){

                                                                                            Baasio *baasio = [Baasio sharedInstance];
                                                                                            NSString *access_token = JSON[@"access_token"];
                                                                                            [baasio setToken:access_token];
                                                                                            
                                                                                            NSDictionary *userReponse = JSON[@"user"];
                                                                                            BaasioUser *loginUser = [BaasioUser user];
                                                                                            [loginUser setEntity:userReponse];
                                                                                            [baasio setCurrentUser:loginUser];
                                                                                            
                                                                                            successBlock();
                                                                                        }
                                                                                        failure:failure];
    [operation start];
}

+ (BaasioUser *)currtuser{
    BaasioUser *user =  [[Baasio sharedInstance]currentUser];
    return user;
}


+ (void)signOut {
    [[Baasio sharedInstance] setCurrentUser:nil];
    [[Baasio sharedInstance] setToken:nil];
}


- (BaasioResponse *)signIn {

    BaasioResponse *_response = [[BaasioResponse alloc]init];
    NSDictionary *params = @{
        @"name":[self objectForKey:@"name"],
        @"password":self.password,
        @"username":self.username,
        @"email":self.email
    };
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"users" parameters:nil];
    NSError *error;
    NSData *data = [params JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        _response.error = error;
        return _response;
    }
    request.HTTPBody = data;
    
    __block BOOL isFinish = false;
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            isFinish = true;
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                                                                                            _response.error = error;
                                                                                            isFinish = true;
                                                                                        }];
    [operation start];
    
#ifndef UNIT_TEST
    while(!isFinish){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
#endif
    return _response;
}


- (void)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                            @"name":[self objectForKey:@"name"],
                            @"password":self.password,
                            @"username":self.username,
                            @"email":self.email
                            };


    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"users" parameters:nil];
    NSError *error;
    NSData *data = [params JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return;
    }
    request.HTTPBody = data;

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success failure:failure];

    [operation start];
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