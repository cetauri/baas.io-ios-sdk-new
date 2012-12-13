//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "BaasioQuery.h"
#import <objc/runtime.h>
@implementation BaasioQuery {

    NSString *_collectionName;
    NSString *_projections;
    NSString *_wheres;
    NSString *_orderKey;
    
    NSMutableArray *_cursors;
    int _pos;

    BaasioQuerySortOrder _order;
//    BaasioGroup* _group;
    
    int _limit;
}
+ (BaasioQuery *)queryWithCollectionName:(NSString *)collectionName
{
    return [[BaasioQuery alloc] initWithCollectionName:collectionName];
}

-(id) initWithCollectionName:(NSString *)collectionName
{
    self = [super init];
    if (self){
        _collectionName = collectionName;
        _cursors = [NSMutableArray array];
        _pos = -1;
    }
    return self;
}

//-(void)setRelation:(BaasioRelation*)relation;

//-(void)setGroup:(BaasioGroup*)group{
//    _group = group;
//}
-(void)setProjections:(NSString *)projections{
    _projections = projections;
}
-(void)setWheres:(NSString *)wheres{
    _wheres = wheres;
}

-(void)setOrderBy:(NSString *)key order:(BaasioQuerySortOrder)order{
    _orderKey = key;
    _order = order;
}

-(void)setLimit: (int)limit{
    _limit = limit;
};

-(NSString *)cursor{
    if (_pos == -1) {
        return @"";
    }
    return _cursors[_pos];
}
-(void)setCursor:(NSString *)cursor{
    _pos = 0;
    _cursors[_pos] = cursor;
}

-(void)setResetCursor{
    _pos = -1;
    _cursors = [NSMutableArray array];
}

-(BOOL)hasMoreEntities{
    
    if (_pos == -1){
        return false;
    } else if (_cursors[_pos] == nil){
        return false;
    }
    return true;
}


-(NSString *)description {

    NSString *ql = @"select ";

    if (_projections != nil) {
        ql= [ql stringByAppendingString:_projections];
    } else {
        ql= [ql stringByAppendingString:@"*"];
    }

    if (_wheres != nil) {
        ql= [ql stringByAppendingFormat:@" where %@", _wheres];
    }

    if (_orderKey != nil) {
        ql= [ql stringByAppendingFormat:@" order by %@ %@", _orderKey, (_order == BaasioQuerySortOrderDESC) ? @"desc" : @"asc"];
    }

    NSString *_sql = [NSString stringWithFormat:@"?ql=%@", [ql stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (_limit != 10){
        _sql = [_sql stringByAppendingFormat:@"&limit=%i", _limit];
    }

//    if (_cursors[_pos] != nil){
    if (_pos != -1){
        _sql = [_sql stringByAppendingFormat:@"&cursor=%@", _cursors[_pos] ];
    }
    NSLog(@"_sql : %@, %i, %i", _sql, _pos, _cursors.count);
    return _sql;
}

-(BaasioRequest *)queryInBackground:(void (^)(NSArray *objects))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock{

    NSString *path = [_collectionName stringByAppendingString:self.description];

    return [NetworkManager connectWithHTTP:path
                                withMethod:@"GET"
                                    params:nil
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;

                                       NSString *cursor = response[@"cursor"];
                                       if (cursor != nil) {
                                           _cursors[++_pos] = response[@"cursor"];
                                           NSLog(@"%i == %@", _pos, _cursors[_pos]);
                                       }else{
                                           NSLog(@"---");
                                       }
                                       
                                       NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                       successBlock(objects);
                                       
                                   }
                                   failure:failureBlock];
}

-(BaasioRequest *)nextInBackground:(void (^)(NSArray *objects))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock
{
    if(![self hasMoreEntities]){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Next entities isn't exist." forKey:NSLocalizedDescriptionKey];
        
        NSString *domain = @"NSObjectNotAvailableException";
        NSError *e = [NSError errorWithDomain:domain code:-1 userInfo:details];
        
        failureBlock(e);
        return nil;
    }
    return [self queryInBackground:successBlock failureBlock:failureBlock];
}

-(BaasioRequest *)prevInBackground:(void (^)(NSArray *objects))successBlock
                      failureBlock:(void (^)(NSError *error))failureBlock
{
    _pos -= 2;
    if(_pos < 0 ){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Prev entities isn't exist." forKey:NSLocalizedDescriptionKey];

        NSString *domain = @"NSObjectNotAvailableException";
        NSError *e = [NSError errorWithDomain:domain code:-1 userInfo:details];
        
        failureBlock(e);
        return nil;
    }
    return [self queryInBackground:successBlock failureBlock:failureBlock];
}



@end