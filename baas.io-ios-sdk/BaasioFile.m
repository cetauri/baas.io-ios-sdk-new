//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioFile.h"
#import "BaasioResponse.h"


@implementation BaasioFile {

}
-(id) init
{
    self = [super init];
    if (self){
        self.entityName = @"files";
    }
    return self;
}

- (void)informationInBackground:(NSString *)uuid
                   successBlock:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = JSON[@"entities"][0];
                                                                                            [self setEntity:dictionary];
                                                                                            successBlock();
                                                                                        }

                                                                                        failure:failure];
    [operation start];
}

- (void)deleteInBackground:(NSString *)uuid
              successBlock:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
{
    
}

- (void)downloadInBackground:(NSString *)uuid
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock
{
    
}


- (void)uploadInBackground:(NSData *)data
              successBlock:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/public/%@", @"1.txt"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:nil];
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    
//    [request setAllHTTPHeaderFields:header];
//    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:failure];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        float progress = totalBytesWritten / totalBytesExpectedToWrite;
        progressBlock(progress);
    }];
    
    [operation start];
}

@end