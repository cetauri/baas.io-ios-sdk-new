//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioPush.h"

@implementation BaasioPush {

}

- (void)sendPushInBackground:(BaasioPushConfig *)config
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = [config dictionary];
    NSLog(@"params : %@", params.description);
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"pushes" parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
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
                                                                                        success:success
                                                                                        failure:failure];
    [operation start];
}


- (void)unregisterInBackground:(NSString *)uuid
                  successBlock:(void (^)(void))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [@"pushes/devices/" stringByAppendingString:uuid];
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

- (void)registerInBackground:(NSString *)deviceID
                        tags:(NSArray *)tags
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"platform" : @"I",
                                @"token" : deviceID,
                                @"tags" : tags
                            };
    NSString *path = @"pushes/devices";
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[[Baasio sharedInstance] getAPIURL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
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
                                                                                        success:success
                                                                                        failure:failure];
    [operation start];

}

@end