//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioFile.h"
#import "AFNetworking.h"
#import "BaasioNetworkManager.h"
#import "Baasio+Private.h"
#import "NetworkActivityIndicatorManager.h"
#import "JSONKit.h"

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

- (BaasioRequest*)getInBackground:(void (^)(BaasioFile *file))successBlock
                     failureBlock:(void (^)(NSError *))failureBlock
{
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];

    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                withMethod:@"GET"
                                    params:nil
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;
                                       NSDictionary *dictionary = response[@"entities"][0];

                                       BaasioFile *_file = [[BaasioFile alloc]init];
                                       [_file setEntity:dictionary];
                                       successBlock(_file);
                                   }
                                   failure:failureBlock];
}

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
{
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];

    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                withMethod:@"DELETE"
                                    params:nil
                                   success:^(id result){
                                       successBlock();
                                   }
                                   failure:failureBlock];

}

- (BaasioRequest*)downloadInBackground:(NSString *)downloadPath
                          successBlock:(void (^)(NSString *))successBlock
                          failureBlock:(void (^)(NSError *))failureBlock
                         progressBlock:(void (^)(float progress))progressBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSString *path = [self.entityName stringByAppendingFormat:@"/%@/data", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];

    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[BaasioNetworkManager sharedInstance] failure:failureBlock];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            successBlock(downloadPath);
                                                                                        }
                                                                                        failure:failure];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
        float progress = (float)totalBytesRead / totalBytesExpectedToRead;
        progressBlock(progress);
    }];
    [operation start];
    [[NetworkActivityIndicatorManager sharedInstance]show];
    return (BaasioRequest*)operation;
}

- (BaasioRequest*)uploadInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock
{
    return [[BaasioNetworkManager sharedInstance] multipartFormRequest:self.entityName
                                                           withMethod:@"POST"
                                                             withBody:_data
                                                               params:self.dictionary
                                                             filename:self.filename
                                                          contentType:_contentType
                                                         successBlock:^(BaasioFile *file) {
                                                             successBlock(file);
                                                         }
                                                         failureBlock:failureBlock
                                                        progressBlock:progressBlock];
}


//- (BaasioRequest*)updateFileInBackground:(void (^)(void))successBlock
//                            failureBlock:(void (^)(NSError *))failureBlock
//                           progressBlock:(void (^)(float progress))progressBlock{
//    
//    
//    
//}

#pragma mark - entity

- (void)setFilename:(NSString *)filename{
    [super setObject:filename forKey:@"filename"];
}

- (NSString*)filename{
    return [super objectForKey:@"filename"];
}


@end