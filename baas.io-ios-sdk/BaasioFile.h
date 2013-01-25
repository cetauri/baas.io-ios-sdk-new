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

/**
 file download asynchronously
 
 @param downloadPath downloadPath
 @param successBlock successBlock
 @param failureBlock failureBlock
 @param progressBlock progressBlock
 */
- (BaasioRequest*)fileDownloadInBackground:(NSString *)downloadPath
                              successBlock:(void (^)(NSString *))successBlock
                              failureBlock:(void (^)(NSError *))failureBlock
                             progressBlock:(void (^)(float progress))progressBlock;
/**
 file upload  asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 @param progressBlock progressBlock
 */
- (BaasioRequest*)fileUploadInBackground:(void (^)(BaasioFile *file))successBlock
                            failureBlock:(void (^)(NSError *))failureBlock
                           progressBlock:(void (^)(float progress))progressBlock;
/**
 file update asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 @param progressBlock progressBlock
 */
- (BaasioRequest*)fileUpdateInBackground:(void (^)(BaasioFile *file))successBlock
                            failureBlock:(void (^)(NSError *))failureBlock
                           progressBlock:(void (^)(float progress))progressBlock;

/**
 update asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)updateInBackground:(void (^)(BaasioFile *file))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


/**
 get asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)getInBackground:(void (^)(BaasioFile *file))successBlock
                     failureBlock:(void (^)(NSError *))failureBlock;

/**
 delete asynchronously
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *))failureBlock;

@end