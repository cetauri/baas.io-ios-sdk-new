//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
#import "BaasioFile.h"



@implementation BaasioEntity {
    NSMutableDictionary *_entity;
}

-(id) init
{
    self = [super init];
    if (self){
        _entity = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)setEntity:(NSDictionary *)entity
{
    _entity = [NSMutableDictionary dictionaryWithDictionary:entity];
}

+ (BaasioEntity *)entitytWithName:(NSString *)entityName {
    BaasioEntity *entity = [[BaasioEntity alloc] init];
    entity.entityName = entityName;
    return entity ;
}


- (BaasioEntity *)save:(NSError **)error {
    
//    __block BOOL isFinish = false;
    __block BaasioEntity *entity = nil;
    BaasioRequest *request = [NetworkManager connectWithHTTP:self.entityName
                            withMethod:@"POST"
                                params:_entity
                               success:^(id result){
                                   NSDictionary *response = (NSDictionary *)result;

                                   NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                   NSString *type = response[@"type"];

                                   entity = [BaasioEntity entitytWithName:type];
                                   [entity setEntity:dictionary];

//                                   isFinish = true;
                               }
                               failure:^(NSError *e){
                                   *error = e;
//                                   isFinish = true;
                               }];
    [request waitUntilFinished];
    
    return entity;
//#ifndef UNIT_TEST
//    while(!isFinish){
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//#endif
//    return nil;

}

- (BaasioRequest*)saveInBackground:(void (^)(BaasioEntity *entity))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock{

    return [NetworkManager connectWithHTTP:self.entityName
                                withMethod:@"POST"
                                    params:_entity
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;
                                       
                                       NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                       NSString *type = response[@"type"];
                                       
                                       BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                       [entity setEntity:dictionary];
                                       
                                       successBlock(entity);
                                   }
                                   failure:failureBlock];
}

- (void)delete:(NSError **)error{
//    __block BOOL isFinish = false;
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    
    BaasioRequest *request = [NetworkManager connectWithHTTP:path
                                                  withMethod:@"DELETE"
                                                      params:nil
                                                     success:^(id result){
//                                                         isFinish = true;
                                                     }
                                                     failure:^(NSError *e){
                                                         *error = e;
//                                                         isFinish = true;
                                                     }];
    [request waitUntilFinished];
    
    return;
//#ifndef UNIT_TEST
//    while(!isFinish){
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//#endif
//    return nil;
}

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
  
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"DELETE"
                                    params:nil
                                   success:^(id result){
                                       successBlock();
                                   }
                                   failure:failureBlock];

}
- (BaasioEntity *)update:(NSError **)error{
//    __block BOOL isFinish = false;
    __block BaasioEntity *entity = nil;
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    
    BaasioRequest *request = [NetworkManager connectWithHTTP:path
                                withMethod:@"PUT"
                                    params:_entity
                                   success:^(id result){
                                         NSDictionary *response = (NSDictionary *)result;
                                         
                                         NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                         NSString *type = response[@"type"];
                                         
                                         entity = [BaasioEntity entitytWithName:type];
                                         [entity setEntity:dictionary];
                                         
//                                         isFinish = true;
                                     }
                                     failure:^(NSError *e){
                                         *error = e;
//                                         isFinish = true;
                                     }];
    [request waitUntilFinished];
    
    return entity;
//#ifndef UNIT_TEST
//    while(!isFinish){
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//#endif
//    return nil;
}

- (BaasioRequest*)updateInBackground:(void (^)(BaasioEntity *entity))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{

    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];

    return [NetworkManager connectWithHTTP:path
                                withMethod:@"PUT"
                                    params:_entity
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;
                                       
                                       NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                       NSString *type = response[@"type"];
                                       
                                       BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                       [entity setEntity:dictionary];
                                       
                                       successBlock(entity);
                                   }
                                   failure:failureBlock];
}


- (BaasioRequest*)connectInBackground:(BaasioEntity *)entity
                         relationship:(NSString*)relationship
                         successBlock:(void (^)(void))successBlock
                         failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@/%@/%@/%@", self.uuid, relationship, entity.entityName, entity.uuid];
    
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"POST"
                                    params:_entity
                                   success:^(id result){
//                                       NSDictionary *response = (NSDictionary *)result;
//                                       NSLog(@"response : %@", response.description);
                                       successBlock();
                                   }
                                   failure:failureBlock];
}

- (BaasioRequest*)disconnectInBackground:(BaasioEntity *)entity
                            relationship:(NSString*)relationship
                            successBlock:(void (^)(void))successBlock
                            failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@/%@/%@/%@", self.uuid, relationship, entity.entityName, entity.uuid];
    
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"DELETE"
                                    params:_entity
                                   success:^(id result){
//                                       NSDictionary *response = (NSDictionary *)result;
//                                       NSLog(@"response : %@", response.description);
                                       successBlock();
                                   }
                                   failure:failureBlock];
}

#pragma mark - Data
- (id)objectForKey:(NSString *)key {
    return _entity[key];
}

// XXX relation??
- (void)setObject:(id)value forKey:(NSString *)key {
    if ([value isMemberOfClass:[BaasioFile class]]){
        [_entity setObject:((BaasioFile*) value).dictionary forKey:key];
    } else if ([value isMemberOfClass:[BaasioUser class]]){
        [_entity setObject:((BaasioUser*) value).dictionary forKey:key];
    } else{
        [_entity setObject:value forKey:key];
    }
}

#pragma mark - Entity
+ (BaasioEntity *)getEntity:(NSString*)entityName uuid:(NSString *)uuid error:(NSError **)error{
//    __block BOOL isFinish = false;
    __block BaasioEntity *entity = nil;
    NSString *path = [entityName stringByAppendingFormat:@"/%@", uuid];
    
    BaasioRequest *request = [NetworkManager connectWithHTTP:path
                                                  withMethod:@"GET"
                                                      params:nil
                                                     success:^(id result){
                                                         NSDictionary *response = (NSDictionary *)result;
                                                         
                                                         NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                                         NSString *type = response[@"type"];
                                                         
                                                         BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                                         [entity setEntity:dictionary];
                                                         
//                                                       isFinish = true;
                                                     }
                                                     failure:^(NSError *e){
                                                         *error = e;
//                                                       isFinish = true;
                                                     }];
    [request waitUntilFinished];
    
    return entity;
//#ifndef UNIT_TEST
//    while(!isFinish){
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
//    }
//#endif
//    return nil;
}

+ (BaasioRequest*)getEntityInBackground:(NSString*)entityName
                         uuid:(NSString *)uuid
                           successBlock:(void (^)(BaasioEntity *entity))successBlock
                           failureBlock:(void (^)(NSError *error))failureBlock;
{
    NSString *path = [entityName stringByAppendingFormat:@"/%@", uuid];

    return [NetworkManager connectWithHTTP:path
                                withMethod:@"GET"
                                    params:nil
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;
                                       
                                       NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:response[@"entities"][0]];
                                       NSString *type = response[@"type"];
                                       
                                       BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                       [entity setEntity:dictionary];
                                       
                                       successBlock(entity);
                                   }
                                   failure:failureBlock];
}

#pragma mark - super
- (NSString *)description{
    return _entity.description;
}

#pragma mark - etc
- (NSDictionary *)dictionary{
    return _entity;
}

-(NSString*)created{
    return _entity[@"created"];
}
-(NSString*)modified{
    return _entity[@"modified"];
}
-(NSString*)uuid{
    return _entity[@"uuid"];
}
-(NSString*)type{
    return _entity[@"type"];
}

-(void)setUuid:(NSString*)uuid{
    _entity[@"uuid"] = uuid;
}

@end