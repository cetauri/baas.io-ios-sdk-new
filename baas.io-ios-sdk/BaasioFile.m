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
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:self.entityName
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {

                                                                        if (_contentType  == nil || [_contentType isEqualToString:@""]) {
                                                                            _contentType = [self mimeTypeForFileAtPath:_fileName];
                                                                        }
                                                        
                                                                        [formData appendPartWithFileData:_data
                                                                                                    name:@"file"
                                                                                                fileName:_fileName
                                                                                                mimeType:_contentType];

                                                                    }];
    request = [[Baasio sharedInstance] setAuthorization:request];

    NSError *error;
    NSData *data = [self.dictionary JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return nil;
    }
    request.HTTPBody = data;
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[BaasioNetworkManager sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = JSON[@"entities"][0];
                                                                                            
                                                                                            BaasioFile *_file = [[BaasioFile alloc]init];
                                                                                            [_file setEntity:dictionary];
                                                                                            successBlock(_file);
                                                                                        }
                                                                                        failure:failure];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        float progress = totalBytesWritten / totalBytesExpectedToWrite;
        progressBlock(progress);
    }];
    
    [operation start];
    [[NetworkActivityIndicatorManager sharedInstance]show];
    return (BaasioRequest*)operation;
}

//- (BaasioRequest*)updateFileInBackground:(void (^)(void))successBlock
//                            failureBlock:(void (^)(NSError *))failureBlock
//                           progressBlock:(void (^)(float progress))progressBlock{
//    
//    
//    
//}

#pragma mark - etc

- (NSString*) mimeTypeForFileAtPath: (NSString *) path {

    // Borrowed from http://stackoverflow.com/questions/5996797/determine-mime-type-of-nsdata-loaded-from-a-file
    // itself, derived from  http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return (NSString *)CFBridgingRelease(mimeType);
}


@end