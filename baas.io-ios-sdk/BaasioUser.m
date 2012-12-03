//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioUser.h"
#import "Baasio.h"
#import "JSONKit.h"
#import "AFNetworking.h"
@implementation BaasioUser {
    NSString *_token;
}
//@synthesize username = _username;
//@synthesize email = _email;
//@synthesize password = _password;
//@synthesize name = _name;

+ (id)user
{
    static dispatch_once_t pred;
    static id _instance = nil;
    dispatch_once(&pred, ^{
        _instance = [[self alloc] init]; // or some other init method
    });
    return _instance;
}


- (void)signIn:(NSError **)error {
       //에러 응답은?
}



- (void)unsubscribeInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [@"users/" stringByAppendingString:@"cetauri"];
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    
    request = [[Baasio sharedInstance] setAuthorization:request];

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
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
                                @"username" : _username,
                                @"password" : _password
                            };
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"token" parameters:params];

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSString *access_token = [JSON objectForKey:@"access_token"];
                                                                                            [[Baasio sharedInstance]setToken:access_token];
                                                                                            
                                                                                            success(request, response, JSON);
                                                                                        }
                                                                                        failure:failure];
    [operation start];
}

+ (BaasioUser *)currtuser {
    return [self user];
}

//
//
//+ (BaasioUser *)signOut {
// return nil;
//}
//
//- (void)signUp {
//
//}
//

- (void)signUpInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                            @"name":self.name,
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

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success failure:failure];

    [operation start];
}



@end