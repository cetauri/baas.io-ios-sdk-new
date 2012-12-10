//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioResponse.h"

@interface BaasioFile : BaasioEntity

- (void)informationInBackground:(NSString *)uuid
                   successBlock:(void (^)(BaasioFile *file))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock;

- (void)deleteInBackground:(NSString *)uuid
              successBlock:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock;

- (void)downloadInBackground:(NSString *)uuid
                    savePath:(NSString *)savePath
                successBlock:(void (^)(NSString *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock;

- (void)uploadInBackground:(NSData *)data
              successBlock:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock;



//TODO : TBI
//changeInBackground
//updateInBackground


@end