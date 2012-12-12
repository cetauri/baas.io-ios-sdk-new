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

- (BaasioRequest*)saveInBackground:(void (^)(BaasioEntity *entity))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:self.entityName parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    NSError *error;
    NSData *data = [_entity JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return nil;
    }
    request.HTTPBody = data;
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:JSON[@"entities"][0]];
                                                                                            NSString *type = JSON[@"type"];
                                                                                            
                                                                                            BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                                                                            [entity setEntity:dictionary];
                                                                                            
                                                                                            successBlock(entity);
                                                                                        }
                                                                                        failure:failure];
    [operation start];
    return (BaasioRequest*)operation;
}

- (void)delete {

}

- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success failure:failure];
    
    [operation start];
    return (BaasioRequest*)operation;

}
- (void)update {

}
- (BaasioRequest*)updateInBackground:(void (^)(BaasioEntity *entity))successBlock
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
        return nil;
    }
    request.HTTPBody = data;

    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:JSON[@"entities"][0]];
                                                                                            NSString *type = JSON[@"type"];
                                                                                            
                                                                                            BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                                                                            [entity setEntity:dictionary];
                                                                                            
                                                                                            successBlock(entity);
                                                                                        }
                                                                                        failure:failure];

    [operation start];
    return (BaasioRequest*)operation;
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
+ (BaasioEntity *)getEntity:(NSString *)uuid error:(NSError **)error{
    return nil;
}

+ (BaasioRequest*)getEntityInBackground:(NSString*)entityName
                         uuid:(NSString *)uuid
                           successBlock:(void (^)(BaasioEntity *entity))successBlock
                           failureBlock:(void (^)(NSError *error))failureBlock;
{
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSString *path = [entityName stringByAppendingFormat:@"/%@", uuid];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    request = [[Baasio sharedInstance] setAuthorization:request];
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){

                                                                                            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:JSON[@"entities"][0]];
                                                                                            NSString *type = JSON[@"type"];
                                                                                            
                                                                                            BaasioEntity *entity = [BaasioEntity entitytWithName:type];
                                                                                            [entity setEntity:dictionary];
                                                                                            
                                                                                            successBlock(entity);
                                                                                        }

                                                                                        failure:failure];
    [operation start];
    return (BaasioRequest*)operation;
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