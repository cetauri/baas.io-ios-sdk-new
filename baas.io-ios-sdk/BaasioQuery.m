//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "BaasioQuery.h"

@implementation BaasioQuery {

    NSString *_collectionName;
    NSString *_projections;
    NSString *_wheres;
    NSString *_orderKey;
    NSString *_cursor;

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
    return _cursor;
}
-(void)setCursor:(NSString *)cursor{
    _cursor = cursor;
}

-(void)setResetCursor{
    _cursor = nil;
}

-(BOOL)hasMoreEntities{
    return (_cursor != nil);
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

    if (_cursor != nil){
        _sql = [_sql stringByAppendingFormat:@"&cursor=%@", _cursor ];
    }

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
                                       
                                       NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                       successBlock(objects);
                                       
                                       _cursor = response[@"cursor"];
                                   }
                                   failure:failureBlock];
}

@end