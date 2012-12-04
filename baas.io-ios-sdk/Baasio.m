//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Baasio.h"

@implementation Baasio {
    NSString *_token;
    BaasioUser *_currentUser;
}

+ (id)sharedInstance
{
  static dispatch_once_t pred;
  static id _instance = nil;
  dispatch_once(&pred, ^{
    _instance = [[self alloc] init]; // or some other init method
  });
  return _instance;
}

+ (void)setApplicationInfo:(NSString *)baasioID applicationName:(NSString *)applicationName
{
    NSString *apiURL = @"https://api.baas.io";
    [Baasio setApplicationInfo:apiURL baasioID:baasioID applicationName:applicationName];
}

+ (void)setApplicationInfo:(NSString *)apiURL baasioID:(NSString *)baasioID applicationName:(NSString *)applicationName
{
    Baasio *baasio = [Baasio sharedInstance];
    baasio.apiURL = apiURL;
    baasio.baasioID = baasioID;
    baasio.applicationName = applicationName;
}

- (NSURL *)getAPIURL{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@", _apiURL, _baasioID, _applicationName];
    return [NSURL URLWithString:url];
}

@end

@implementation Baasio(Private)

- (void)setToken:(NSString*)token{
    _token = token;
}

#pragma mark - API Authorization method
- (NSMutableURLRequest *)setAuthorization:(NSMutableURLRequest *)request{
    if (_token != nil) {
        [request addValue:[@"Bearer " stringByAppendingString:_token] forHTTPHeaderField:@"Authorization"];
    }

    return request;
}

#pragma mark - API response method
- (void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure:(void (^)(NSError *))failureBlock {

    void (^failure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        if (JSON == nil){
            failureBlock(error);
            return;
        }
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:JSON[@"error_description"] forKey:NSLocalizedDescriptionKey];

        NSString *domain = JSON[@"error"];
        NSError *e = [NSError errorWithDomain:domain code:error.code userInfo:details];

        failureBlock(e);
    };
    return failure;
}

- (void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success:(void (^)(NSDictionary *response))successBlock {
    void (^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSLog(@"json : :%@", JSON);
        successBlock(JSON);
    };
    return success;
}

- (void (^)(NSURLRequest *, NSHTTPURLResponse *, id))successWithVoid:(void (^)(void))successBlock {
    void (^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSLog(@"json : :%@", JSON);
        successBlock();
    };
    return success;
}

- (BaasioUser*)currentUser{
    return _currentUser;
}

- (void)setCurrentUser:(BaasioUser*)currentUser{
    _currentUser = currentUser;
}

@end