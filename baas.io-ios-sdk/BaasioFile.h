//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioFileOptions.h"
#import "BaasioEntity.h"
#import "BaasioRequest.h"

/**
    A bass.io Framework File Object.
*/
@interface BaasioFile : BaasioEntity

@property(strong) NSString *downloadPath;
@property(strong) NSData *data;
@property(strong) BaasioFileOptions *options;

- (BaasioRequest*)informationInBackground:(void (^)(BaasioFile *file))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock;

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock;

- (BaasioRequest*)downloadInBackground:(void (^)(NSString *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock;

- (BaasioRequest*)uploadInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock;

//TODO : TBI
//changeInBackground
//updateInBackground


@end