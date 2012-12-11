//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "BaasioQuery.h"

@interface BaasioEntity : NSObject

@property(strong) NSString *entityName;
@property(strong) NSString *uuid;
@property(readonly, strong, getter = created) NSDate *created;
@property(readonly, strong, getter = modified) NSDate *modified;
@property(readonly, strong, getter = type) NSString *type;

-(void)setEntity:(NSDictionary *)entity;

+ (BaasioEntity *)entitytWithName:(NSString *)string;


//- (void)save;

- (void)saveInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;


//- (void)update;

- (void)updateInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


//- (void)delete;
- (void)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


- (void)refresh;


#pragma mark - Data
- (NSString *)objectForKey:(NSString *)string;
- (void)setObject:(id)value forKey:(NSString *)key;
//- (void)setValue:(id)value forKey:(NSString *)key;

#pragma mark - Query
- (BaasioEntity *)getEntity:(NSString *)uuid;

- (void)getEntityInBackground:(NSString *)uuid
                           successBlock:(void (^)(void))successBlock
                           failureBlock:(void (^)(NSError *error))failureBlock;

//TODO Query
//+ (BaasioEntity *)findEntity:(BaasioQuery *)query;
//+ (BaasioEntity *)findEntityInBackground:(BaasioQuery *)query;

//+ (NSArray *)findEntities:(BaasioQuery *)query;
//+ (NSArray *)findEntitiesInBackground:(BaasioQuery *)query;

#pragma mark - super
- (NSString *)description;


#pragma mark - etc
- (NSDictionary *)dictionary;
@end