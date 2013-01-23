//
//  GroupTest.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 13..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "GroupTest.h"
#import "BaasioGroup.h"
#import "BaasioQuery.h"
#import "Baasio.h"
@implementation GroupTest {
    BOOL exitRunLoop;
    NSString *groupName;
}
static NSString *uuid;

- (void)setUp
{
    //    [super setUp];
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    // Set-up code here.
    
    groupName = @"path";
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}
- (void)test_1_createGroup{
    BaasioGroup *group = [[BaasioGroup alloc]init];
    
    [group setObject:groupName forKey:@"path"];
    [group saveInBackground:^(BaasioGroup *group){
                    NSLog(@"group : %@", group.description);
                    uuid = group.uuid;
                    exitRunLoop = true;
                    
                }
                 failureBlock:^(NSError *error){
                     exitRunLoop = true;
                     NSLog(@"fail : %@", error.localizedDescription);
                     STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 }];
    [self runTestLoop];
}

- (void)test_2_updateGroup{
    BaasioGroup *group = [[BaasioGroup alloc]init];
    group.uuid = uuid;
    [group setObject:@"name" forKey:@"name"];
    [group setObject:@"cetaurui" forKey:@"cetaurui"];
    
    [group updateInBackground:^(BaasioGroup *group){
                    NSLog(@"group : %@", group.description);
                    exitRunLoop = true;
                    
                }
                 failureBlock:^(NSError *error){
                     exitRunLoop = true;
                     NSLog(@"fail : %@", error.localizedDescription);
                     STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 }];
    
    [self runTestLoop];
}

- (void)test_3_addGroup{
    BaasioGroup *group = [[BaasioGroup alloc]init];
    [group setUserName:@"groupTest"];
    [group setGroupName:groupName];
    
    [group addInBackground:^(BaasioGroup *group){
                    NSLog(@"group : %@", group.description);
//                    uuid = group.uuid;
                    exitRunLoop = true;
                    
                }
                 failureBlock:^(NSError *error){
                     exitRunLoop = true;
                     NSLog(@"fail : %@", error.localizedDescription);
                     STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 }];
    
    [self runTestLoop];
    
    
    group = [[BaasioGroup alloc]init];
    [group setUserName:@"groupTest1"];
    [group setGroupName:groupName];

    [group addInBackground:^(BaasioGroup *group){
                    NSLog(@"group : %@", group.description);
                    //                    uuid = group.uuid;
                    exitRunLoop = true;
                    
                }
              failureBlock:^(NSError *error){
                  exitRunLoop = true;
                  NSLog(@"fail : %@", error.localizedDescription);
                  STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
              }];
    
    [self runTestLoop];
}
- (void)test_4_removeGroup{
    BaasioGroup *group = [[BaasioGroup alloc]init];
    [group setUserName:@"groupTest"];
    [group setGroupName:groupName];

    [group removeInBackground:^(){
                    exitRunLoop = true;
                    
                }
              failureBlock:^(NSError *error){
                  exitRunLoop = true;
                  NSLog(@"fail : %@", error.localizedDescription);
                  STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
              }];
    
    [self runTestLoop];
}

- (void)test_5_queryGroup{
    BaasioQuery *query = [BaasioQuery queryWithGroup:groupName];
    [query queryInBackground:^(NSArray *array) {
                    NSLog(@"array : %@", array.description);
                    STAssertTrue(array.count == 1, @"count is mismatch.");
                    exitRunLoop = true;
                }
                failureBlock:^(NSError *error){
                    NSLog(@"fail : %@", error.localizedDescription);
                    STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                    exitRunLoop = true;
                }];
    
    [self runTestLoop];
}

- (void)test_6_deleteGroup{
   BaasioGroup *group = [[BaasioGroup alloc]init];
    group.uuid = uuid;
    [group deleteInBackground:^(void){
                    exitRunLoop = true;
                }
                 failureBlock:^(NSError *error){
                     exitRunLoop = true;
                     NSLog(@"fail : %@", error.localizedDescription);
                     STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 }];
    
    [self runTestLoop];
}

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end
