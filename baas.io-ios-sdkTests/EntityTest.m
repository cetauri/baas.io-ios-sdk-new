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
}
- (void)setUp
{
    [super setUp];
    exitRunLoop = NO;
    
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    
}


- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}
static NSString *uuid;
//static BaasioEntity *entity;
- (void)test_1_EntitySave
{
    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
    [entity setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
    [entity setObject:@"Sean Plott" forKey:@"playerName"];
    [entity setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
    [entity saveInBackground:^(void) {
                                exitRunLoop = YES;
                            }
                    failureBlock:^(NSError *error) {
                        NSLog(@"fail : %@", error.localizedDescription);
                        STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                        exitRunLoop = YES;
                    }];
    
    [self runTestLoop];
    uuid = entity.uuid;
}
//
- (void)test_2_EntityInfo
{
    NSLog(@"_entity : %@", uuid);
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
//    NSString *playerName = entity[@"playerName"];
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
- (void)test_5_EntityDelete
{
    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
    entity.uuid = uuid;
    [entity deleteInBackground:^(void) {
                                    exitRunLoop = YES;
                                }
                  failureBlock:^(NSError *error) {
                                  NSLog(@"fail : %@", error.localizedDescription);
                                  STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                                  exitRunLoop = YES;
                              }];
    
    [self runTestLoop];
    
}

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end