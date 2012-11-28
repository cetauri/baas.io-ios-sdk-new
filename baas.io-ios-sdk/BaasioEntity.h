//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "BaasioQuery.h"

@interface BaasioEntity : NSObject

@property(strong) NSString *entityName;
@property(strong) NSString *metadata;
@property(strong) NSString *entitytId;
@property(strong) NSDate *updated;
@property(strong) NSString *type;
@property(strong) NSString *name;
@property(strong) NSDate *created;

+ (BaasioEntity *)entitytWithName:(NSString *)string;

- (void)setObject:(NSNumber *)number forKey:(NSString *)key;

- (void)save;

- (void)saveInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;


- (void)update;

- (void)updateInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


- (void)delete;
- (void)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


- (void)refresh;


#pragma mark - Data
- (NSString *)objectForKey:(NSString *)string;


#pragma mark - Query
+ (BaasioEntity *)getEntity:(NSString *)uuid;
+ (BaasioEntity *)getEntityInBackground:(NSString *)uuid;

+ (BaasioEntity *)findEntity:(BaasioQuery *)query;
+ (BaasioEntity *)findEntityInBackground:(BaasioQuery *)query;

+ (NSArray *)findEntities:(BaasioQuery *)query;
+ (NSArray *)findEntitiesInBackground:(BaasioQuery *)query;
@end