//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioUser.h"
#import "Baasio.h"
#import "JSONKit.h"
#import "AFNetworking.h"
static BaasioUser  *currentUser;
@implementation BaasioUser {

}
@synthesize username = _username;
@synthesize email = _email;
@synthesize password = _password;
@synthesize name = _name;


+ (BaasioUser *)user {
    return [[BaasioUser alloc]init];
}

- (void)signIn:(NSError **)error {
       //에러 응답은?
}

//- (void)addAuthorization:(NSMutableURLRequest *)request{
//    if (_access_token != nil && ![_access_token isEqualToString:@""]){
//        [request addValue:[NSString stringWithFormat:@"Bearer %@", _access_token] forHTTPHeaderField:@"Authorization"];
//    }
//}

- (void)signInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"grant_type" : @"password",
                                @"username" : _username,
                                @"password" : _password
                            };
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:[[Baasio createInstance] getAPIURL]]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"token" parameters:params];

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [self success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [self failure:failureBlock];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:failure];
    [operation start];
}
//
//+ (BaasioUser *)currtuser {
//    return currentUser;
//}
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
    NSDictionary *params = @{@"name":@"username"};//,@"password":@"cetauri",@"username":@"cetauri4",@"email":@"cetauri+4@gmail.com"


    NSURL *url = [NSURL URLWithString:[[Baasio createInstance]getAPIURL]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    [httpClient postPath:@"https://api.baas.io/cetauri/sandbox/users?username=cetauri"
              parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"v1", @"username", @"v2", @"email", nil]

                 success:^(AFHTTPRequestOperation *operation, id responseObject){
                     NSLog(@"--------- Operation succeeded");

                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     NSLog(@"--------- Operation failed : %@", operation.responseString);

                 }];
    
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"https://api.baas.io/cetauri/sandbox/users" parameters:params];
//
////    AFFormURLParameterEncoding,
////    AFJSONParameterEncoding,
////    AFPropertyListParameterEncoding,
//    
////    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [self success:successBlock];
////    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [self failure:failureBlock];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                                                            NSLog(@"Operation succeeded");
//
//                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                                                            NSLog(@"Operation failed : %@", JSON);
//                                                                                        }];
//
//    [operation start];
}

#pragma mark - API response method
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock {
//    failureBlock:(void (^)(NSError *error))failureBlock
    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        if (JSON == nil){
            failureBlock(error);
            return;
        }
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:[JSON objectForKey:@"error_description"] forKey:NSLocalizedDescriptionKey];

        NSString *domain = [JSON objectForKey:@"error"];
        NSError *e = [NSError errorWithDomain:domain code:error.code userInfo:details];

        failureBlock(e);
    };
    return failure;
}

- (void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success:(void (^)(void))successBlock {
    void (^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSLog(@"json : :%@", JSON);
        successBlock();
    };
    return success;
}

@end