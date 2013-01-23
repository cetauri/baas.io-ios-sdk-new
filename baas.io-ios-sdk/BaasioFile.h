//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
#import "BaasioRequest.h"

/**
 A bass.io Framework File Object.
*/
@interface BaasioFile : BaasioEntity

@property(strong) NSString *filename;
@property(strong) NSString *contentType;
@property(strong) NSData *data;

- (BaasioRequest*)getInBackground:(void (^)(BaasioFile *file))successBlock
                     failureBlock:(void (^)(NSError *))failureBlock;

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock;

- (BaasioRequest*)downloadInBackground:(NSString *)downloadPath
                          successBlock:(void (^)(NSString *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock
               progressBlock:(void (^)(float progress))progressBlock;

- (BaasioRequest*)uploadInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *))failureBlock
             progressBlock:(void (^)(float progress))progressBlock;

- (BaasioRequest*)updateFileInBackground:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *))failureBlock
                       progressBlock:(void (^)(float progress))progressBlock;



@end