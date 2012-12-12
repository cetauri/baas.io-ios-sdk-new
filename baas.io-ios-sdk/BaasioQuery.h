//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//

typedef enum {
    BaasioQuerySortOrderASC,
    BaasioQuerySortOrderDESC
} BaasioQuerySortOrder;

#import <Foundation/Foundation.h>
#import "BaasioGroup.h"
@interface BaasioQuery : NSObject

+ (BaasioQuery *)queryWithCollectionName:(NSString *)collectionName;
//-(void)setRelation:(BaasioRelation*)relation;

//-(void)setGroup:(BaasioGroup*)group;
-(void)setProjections:(NSString *)projections;
-(void)setWheres:(NSString *)wheres;
-(void)setOrderBy:(NSString *)key order:(BaasioQuerySortOrder)order;///order
-(void)setLimit: (int)limit;

-(NSString *)cursor;
-(void)setCursor:(NSString *)cursor;
-(void)setResetCursor;
-(BOOL)hasMoreEntities;

-(NSString *)description;


-(void)queryInBackground:(void (^)(NSArray *objects))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

@end
