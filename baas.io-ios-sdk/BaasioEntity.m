//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"

@implementation BaasioEntity {

}
@synthesize entitytId = _entitytId;
@synthesize updated = _updated;
@synthesize type = _type;
@synthesize name = _name;
@synthesize created = _created;
@synthesize metadata = _metadata;


- (void)setObject:(NSNumber *)number forKey:(NSString *)key {

}

+ (BaasioEntity *)entitytWithName:(NSString *)string {
 return nil;
}

- (void)save {

}

- (void)saveInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock{

}

- (void)delete {

}

- (void)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{

}
- (void)update {

}
- (void)updateInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{

}

- (void)refresh {

}


#pragma mark - Data
- (NSString *)objectForKey:(NSString *)string {
 return nil;
}


#pragma mark - Query
- (BaasioEntity *)getEntity:(NSString *)uuid {
    return nil;
}

- (BaasioEntity *)findEntity:(BaasioQuery *)query {
    return nil;
}

- (NSArray *)findEntities:(BaasioQuery *)query {
    return nil;
}

- (BaasioEntity *)getEntityInBackground:(NSString *)uuid {
    return nil;
}


- (BaasioEntity *)findEntityInBackground:(BaasioQuery *)query {
    return nil;
}

- (NSArray *)findEntitiesInBackground:(BaasioQuery *)query {
    return nil;
}


@end