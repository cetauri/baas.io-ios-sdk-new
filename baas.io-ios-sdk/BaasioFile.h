//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioResponse.h"

@interface BaasioFile : NSObject
- (void)information:(NSString *)string successBlock:(void (^)(NSDictionary *))block failureBlock:(void (^)(NSError *))block1;

- (void)delete:(NSString *)string successBlock:(void (^)(BaasioResponse *))block failureBlock:(void (^)(NSError *))block1;

- (void)download:(NSString *)string successBlock:(void (^)(BaasioResponse *))block failureBlock:(void (^)(NSError *))block1;

- (void)upload:(NSData *)data successBlock:(void (^)(BaasioResponse *))block failureBlock:(void (^)(NSError *))block1;
@end