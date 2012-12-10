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
                        STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                        exitRunLoop = YES;
                    }];
    
    [self runTestLoop];
    uuid = entity.uuid;
}


- (void)test_3_EntityUpdate
{
    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
    entity.uuid = uuid;
    [entity setObject:@"30" forKey:@"duration"];

    [entity updateInBackground:^(void) {
                                    exitRunLoop = YES;
                                }
                  failureBlock:^(NSError *error) {
                                    NSLog(@"fail : %@", error.localizedDescription);
                                    STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                                    exitRunLoop = YES;
                                }];
    [self runTestLoop];
}

- (void)test_4_EntityInfo
{
    NSLog(@"_entity : %@", uuid);
    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
    [entity getEntityInBackground:uuid
                     successBlock:^(void) {
                        exitRunLoop = YES;
                    }
                    failureBlock:^(NSError *error) {
                        NSLog(@"fail : %@", error.localizedDescription);
                        STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                        exitRunLoop = YES;
                    }];

    [self runTestLoop];
    NSLog(@"%@", entity.description);
}
- (void)test_5_EntityDelete
{
    BaasioEntity *entity = [BaasioEntity entitytWithName:@"GameScore"];
    entity.uuid = uuid;
    [entity deleteInBackground:^(void) {
                                    exitRunLoop = YES;
                                }
                  failureBlock:^(NSError *error) {
                                  NSLog(@"fail : %@", error.localizedDescription);
                                  STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
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