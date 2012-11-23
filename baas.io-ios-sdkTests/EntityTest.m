//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EntityTest.h"
#import "BaasioEntity.h"
#import "BaasioQuery.h"


@implementation EntityTest {

}
- (void)setUp
{
    [super setUp];

    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}
//
//- (void)testEntitySave
//{
//    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
//    [entity setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
//    [entity setObject:@"Sean Plott" forKey:@"playerName"];
//    [entity setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
//    [entity save];
//    [entity save];
//
//}
//
//- (void)testEntityInfo
//{
//    BaasioQuery *query = [BaasioQuery queryWithEntityName:@"GameScore"];
//    BaasioEntity *entity = [query entitytWithID:@"bd397ea1-a71c-3249-8a4c-62fd53c78ce7type"];
//
////    BaasioEntity *entity = [BaasioEntity entitytWithID:@"bd397ea1-a71c-3249-8a4c-62fd53c78ce7type" with:query];
//
//
//    NSString *entitytId = entity.entitytId;
//    NSDate *updated = entity.updated;
//    NSDate *created = entity.created;
//    NSString *type = entity.type;
//    NSString *name = entity.name;
//    NSString *metadata = entity.metadata;
//    NSString *playerName = [entity objectForKey:@"playerName"];
//
//    [entity refresh];
//}
//
//- (void)testEntityUpdate
//{
//    BaasioQuery *query = [BaasioQuery queryWithEntityName:@"GameScore"];
//    BaasioEntity *entity = [query entitytWithID:@"bd397ea1-a71c-3249-8a4c-62fd53c78ce7type"];
//
//    NSString *entitytId = entity.entitytId;
//    NSDate *updated = entity.updated;
//    NSDate *created = entity.created;
//    NSString *type = entity.type;
//    NSString *name = entity.name;
//    NSString *metadata = entity.metadata;
//
//    [entity update];
//}
//
//- (void)testEntityDelete
//{
//    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
//    entity.entitytId = @"bd397ea1-a71c-3249-8a4c-62fd53c78ce7type";
////    [entity deleteInBackground];
//}

@end