//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioFile.h"

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

- (BaasioRequest*)informationInBackground:(void (^)(BaasioFile *file))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = JSON[@"entities"][0];
                                                                                            
                                                                                            BaasioFile *_file = [[BaasioFile alloc]init];
                                                                                            [_file setEntity:dictionary];
                                                                                            successBlock(_file);
                                                                                        }

                                                                                        failure:failure];
    [operation start];
    return (BaasioRequest*)operation;
}

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:failure];
    [operation start];
    return (BaasioRequest*)operation;
}

- (BaasioRequest*)downloadInBackground:(void (^)(NSString *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@/download", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            successBlock(self.downloadPath);
                                                                                        }
                                                                                        failure:failure];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:self.downloadPath append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
        float progress = (float)totalBytesRead / totalBytesExpectedToRead;
        progressBlock(progress); 
    }];
    [operation start];
    return (BaasioRequest*)operation;
}

- (BaasioRequest*)uploadInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/public/%@", [self createRandomPath]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:nil];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    
    [request setAllHTTPHeaderFields:self.options.dictionary];
    [request setHTTPBody:self.data];
    
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
    return (BaasioRequest*)operation;
}



#pragma mark - etc
-(NSString *)createRandomPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *yyyymmdd = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"HH"];
    NSString *HH = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"mm"];
    NSString *mm = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"ss"];
    NSString *ss = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"SSS"];
    NSString *SSS = [formatter stringFromDate:[NSDate date]];
    
    
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@", yyyymmdd, HH, mm, ss, SSS, (__bridge NSString *)(uuidStringRef)];
    
    return path;
}

- (NSString*) mimeTypeForFileAtPath: (NSString *) path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
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