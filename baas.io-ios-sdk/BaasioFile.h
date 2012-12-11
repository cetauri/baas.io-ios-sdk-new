//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioResponse.h"
#import "BaasioFileOptions.h"
@interface BaasioFile : BaasioEntity

@property(strong) NSString *downloadPath;
@property(strong) NSData *data;
@property(strong) BaasioFileOptions *options;

- (void)informationInBackground:(void (^)(BaasioFile *file))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock;

- (void)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock;

- (void)downloadInBackground:(void (^)(NSString *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock;

- (void)uploadInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock;



//TODO : TBI
//changeInBackground
//updateInBackground


@end