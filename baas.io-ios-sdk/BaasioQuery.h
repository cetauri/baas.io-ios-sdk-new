//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//

typedef enum {
    BaasioQuerySortOrderASC,
    BaasioQuerySortOrderDESC
} BaasioQuerySortOrder;

#import "BaasioGroup.h"
@interface BaasioQuery : NSObject

+ (BaasioQuery *)queryWithCollectionName:(NSString *)collectionName;
+ (BaasioQuery *)queryWithGroupName:(NSString *)group;

//-(void)setRelation:(BaasioRelation*)relation;

-(void)setProjections:(NSString *)projections;
-(void)setWheres:(NSString *)wheres;
-(void)setOrderBy:(NSString *)key order:(BaasioQuerySortOrder)order;
-(void)setLimit: (int)limit;

-(NSString *)cursor;
-(void)setCursor:(NSString *)cursor;
-(void)setResetCursor;
-(BOOL)hasMoreEntities;

-(NSString *)description;

-(BaasioRequest *)nextInBackground:(void (^)(NSArray *objects))successBlock
                       failureBlock:(void (^)(NSError *error))failureBlock;

-(BaasioRequest *)prevInBackground:(void (^)(NSArray *objects))successBlock
                       failureBlock:(void (^)(NSError *error))failureBlock;

-(BaasioRequest *)queryInBackground:(void (^)(NSArray *objects))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;


- (BaasioUser *)following;
- (BaasioUser *)followers;
@end
