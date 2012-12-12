//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QueryTest.h"
#import "BaasioQuery.h"

#import "BaasioEntity.h"
@implementation QueryTest {
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
- (void)test_1_QueryBuild{
    BaasioQuery *query = [BaasioQuery queryWithCollectionName:@"tests"];
    [query setCursor:@"cursor"];
    [query setLimit:11];
    [query setProjections:@"name, title"];
    [query setOrderBy:@"name" order:BaasioQuerySortOrderASC];
    [query setWheres:@"name = 1"];

    NSLog(@"description : %@", query.description);
}
- (void)test_1_QueryTest{
    BaasioQuery *query = [BaasioQuery queryWithCollectionName:@"tests"];
    [query setCursor:@"cursor"];
    [query setLimit:3];
    [query queryInBackground:^(NSArray *array) {
        NSLog(@"array : %i", array.count);
                            STAssertTrue(array.count == 3, @"count is not equals.", nil);
                            exitRunLoop = YES;
                        }
                        failureBlock:^(NSError *error) {
                            NSLog(@"fail : %@", error.localizedDescription);
                            STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                            exitRunLoop = YES;
                        }];


    [self runTestLoop];
    [query queryInBackground:^(NSArray *array) {
        STAssertEquals(array.count, 3, @"count is not equals.", nil);
        exitRunLoop = YES;
    }
    failureBlock:^(NSError *error) {
        NSLog(@"fail : %@", error.localizedDescription);
        STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
        exitRunLoop = YES;
    }];

    
    [self runTestLoop];
}

- (void)testQueryEntity{
//    BaasioQuery *description = [BaasioQuery createWithEntityName:@"sandbox"];
//    query = [query description:@"xxxxxx"];

//    BaasioEntity *entity = [BaasioEntity getEntity:description];
}

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end