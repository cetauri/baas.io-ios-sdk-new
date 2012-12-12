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

- (void)save {

}

- (void)saveInBackground:(void (^)(void))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:self.entityName parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    NSError *error;
    NSData *data = [_entity JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return;
    }
    request.HTTPBody = data;
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *entity = JSON[@"entities"][0];
                                                                                            [self setEntity:entity];
                                                                                            success(request, response, JSON);
                                                                                        }
                                                                                        failure:failure];
    [operation start];
}

- (void)delete {

}

- (void)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success failure:failure];
    
    [operation start];

}
- (void)update {

}
- (void)updateInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{

    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];

    NSError *error;
    NSData *data = [_entity JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return;
    }
    request.HTTPBody = data;

    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] successWithVoid:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success failure:failure];

    [operation start];
}

- (void)refresh {

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

#pragma mark - Query
- (BaasioEntity *)getEntity:(NSString *)uuid {
    return nil;
}


- (void)getEntityInBackground:(NSString *)uuid
                           successBlock:(void (^)(void))successBlock
                           failureBlock:(void (^)(NSError *error))failureBlock;
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSString *path = [_entityName stringByAppendingFormat:@"/%@", uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = JSON[@"entities"][0];
                                                                                            [self setEntity:dictionary];
                                                                                            successBlock();
                                                                                        }

                                                                                        failure:failure];
    [operation start];
}
//+ (BaasioEntity *)findEntity:(BaasioQuery *)description {
//    return nil;
//}
//
//+ (NSArray *)findEntities:(BaasioQuery *)description {
//    return nil;
//}


//+ (BaasioEntity *)findEntityInBackground:(BaasioQuery *)description {
//    return nil;
//}
//
//+ (NSArray *)findEntitiesInBackground:(BaasioQuery *)description {
//    return nil;
//}

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