//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"

@implementation BaasioEntity {
    NSMutableDictionary *_dictionary;

}
@synthesize entitytId = _entitytId;
@synthesize updated = _updated;
@synthesize type = _type;
@synthesize name = _name;
@synthesize created = _created;
@synthesize metadata = _metadata;

-(id) init
{
    self = [super init];
    if (self){
        _dictionary= [NSMutableDictionary dictionary];
    }
    return self;
}


+ (BaasioEntity *)entitytWithName:(NSString *)entityName {
    BaasioEntity *entity = [[BaasioEntity alloc] init];
    entity.entityName = entityName;
    return entity ;
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
- (id)objectForKey:(NSString *)key {
    return [_dictionary objectForKey:key];
}

- (void)setObject:(id)value forKey:(NSString *)key {
    [_dictionary setObject:value forKey:key];
}


#pragma mark - Query
+ (BaasioEntity *)getEntity:(NSString *)uuid {
    return nil;
}

+ (BaasioEntity *)findEntity:(BaasioQuery *)query {
    return nil;
}

+ (NSArray *)findEntities:(BaasioQuery *)query {
    return nil;
}

+ (BaasioEntity *)getEntityInBackground:(NSString *)uuid {
    return nil;
}


+ (BaasioEntity *)findEntityInBackground:(BaasioQuery *)query {
    return nil;
}

+ (NSArray *)findEntitiesInBackground:(BaasioQuery *)query {
    return nil;
}


@end