//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BaasioRequest.h"

@interface BaasioEntity : NSObject

@property(strong) NSString *entityName;
@property(strong) NSString *uuid;
@property(readonly, strong, getter = created) NSDate *created;
@property(readonly, strong, getter = modified) NSDate *modified;
@property(readonly, strong, getter = type) NSString *type;

-(void)setEntity:(NSDictionary *)entity;

+ (BaasioEntity *)entitytWithName:(NSString *)entityName;


- (BaasioEntity *)save:(NSError **)error;

- (BaasioRequest*)saveInBackground:(void (^)(BaasioEntity *entity))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock;


- (BaasioEntity *)update:(NSError **)error;

- (BaasioRequest*)updateInBackground:(void (^)(BaasioEntity *entity))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


- (void)delete:(NSError **)error;
- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


#pragma mark - relation
- (void) connect:(BaasioEntity *)entity
    relationship:(NSString*)relationship
           error:(NSError **)error;

- (BaasioRequest*)connectInBackground:(BaasioEntity *)entity
                         relationship:(NSString*)relationship
                         successBlock:(void (^)(void))successBlock
                         failureBlock:(void (^)(NSError *error))failureBlock;

- (void) disconnect:(BaasioEntity *)entity
    relationship:(NSString*)relationship
           error:(NSError **)error;

- (BaasioRequest*)disconnectInBackground:(BaasioEntity *)entity
                            relationship:(NSString*)relationship
                            successBlock:(void (^)(void))successBlock
                            failureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - Data
- (NSString *)objectForKey:(NSString *)string;
- (void)setObject:(id)value forKey:(NSString *)key;

#pragma mark - Entity

+ (BaasioEntity *)getEntity:(NSString*)entityName
                       uuid:(NSString *)uuid
                      error:(NSError **)error;

+ (BaasioRequest*)getEntityInBackground:(NSString*)entityName
                         uuid:(NSString *)uuid
                 successBlock:(void (^)(BaasioEntity *entity))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - super
- (NSString *)description;


#pragma mark - etc
- (NSDictionary *)dictionary;
@end