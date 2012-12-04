//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EntityTest.h"
#import "BaasioEntity.h"
#import "BaasioQuery.h"
#import "Baasio.h"

@implementation EntityTest {
    BOOL exitRunLoop;
    BaasioEntity *entity;
}
- (void)setUp
{
//    [super setUp];
    exitRunLoop = NO;
    
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    
}


- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

//static BaasioEntity *entity;
- (void)test_1_EntitySave
{
    entity = [BaasioEntity entitytWithName:@"GameScore"];
    [entity setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
    [entity setObject:@"Sean Plott" forKey:@"playerName"];
    [entity setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
    [entity saveInBackground:^(NSDictionary *response) {
                                NSLog(@"success");
                                exitRunLoop = YES;
                            }
                    failureBlock:^(NSError *error) {
                        NSLog(@"fail : %@", error.localizedDescription);
                        STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                        exitRunLoop = YES;
                    }];
    
    [self runTestLoop];
}
//
- (void)test_2_EntityInfo
{
    NSLog(@"_entity : %@", entity.entitytId);
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
}
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
- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end