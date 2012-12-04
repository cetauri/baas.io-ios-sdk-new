//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BaasioEntity.h"
#import "Baasio.h"
#import "Baasio+Private.h"
#import "JSONKit.h"
#import "AFNetworking.h"
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

- (void)saveInBackground:(void (^)(NSDictionary *response))successBlock
            failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSURL *url = [[Baasio sharedInstance] getAPIURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:self.entityName parameters:nil];
    NSError *error;
    NSData *data = [_dictionary JSONDataWithOptions:JKSerializeOptionNone error:&error];
    if (error != nil) {
        failureBlock(error);
        return;
    }
    request.HTTPBody = data;
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, id) = [[Baasio sharedInstance] success:successBlock];
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = [[Baasio sharedInstance] failure:failureBlock];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            NSLog(@"JSON : %@", JSON);
                                                                                            NSDictionary *entities = [[JSON objectForKey:@"entities"] objectAtIndex:0];
                                                                                            self.entitytId = [entities objectForKey:@"uuid"];
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
    
    NSString *path = [self.entityName stringByAppendingFormat:@"/%@", self.entitytId];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:path parameters:nil];
    NSError *error;
    NSData *data = [_dictionary JSONDataWithOptions:JKSerializeOptionNone error:&error];
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

//- (void)setValue:(id)value forKey:(NSString *)key {
//    [_dictionary setValue:value forKey:key];
//}


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