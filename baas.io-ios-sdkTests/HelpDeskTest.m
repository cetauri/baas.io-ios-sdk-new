//
//  HelpDeskTest.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 20..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "HelpDeskTest.h"
#import "BaasioHelpdesk.h"
#import "BaasioUser.h"
@implementation HelpDeskTest{
    BOOL exitRunLoop;
}


- (void)setUp
{
    [super setUp];
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    // Set-up code here.
    
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)test_1_helpList
{
    BaasioHelpdesk *helpdesk = [[BaasioHelpdesk alloc]init];
    [helpdesk getHelpList:@""
             successBlock:^(NSArray *array) {
                 NSLog(@"array : %@", array.description);
                 exitRunLoop = YES;
                 
             }
             failureBlock:^(NSError *error) {
                 NSLog(@"fail : %@", error.localizedDescription);
                 STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 exitRunLoop = YES;
             }];
    
    [self runTestLoop];
}

- (void)test_2_helpDetail
{
    BaasioHelpdesk *helpdesk = [[BaasioHelpdesk alloc]init];
    [helpdesk getHelpDetail:@"cf334051-2dee-47ef-b787-2d7f5a889db0"
             successBlock:^(NSDictionary *dictionary) {
                 NSLog(@"dictionary : %@", dictionary);
                 exitRunLoop = YES;
             }
             failureBlock:^(NSError *error) {
                 NSLog(@"fail : %@", error.localizedDescription);
                 STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 exitRunLoop = YES;
             }];
    
    [self runTestLoop];
}




//- (void)test_3_sendQuestion
//{
//    BaasioUser *user = [BaasioUser user];
//    user.username = @"helpdesk";
//    user.password = @"helpdesk";
//    [user signInBackground:^(void){
//
//        BaasioHelpdesk *helpdesk = [[BaasioHelpdesk alloc]init];
//        NSDictionary *param = @{
//            @"email" : @"email@email.com",
//            @"content" : @"내용입니다 내용입니다.2",
//            @"temporary_answer" : @"temporary_answer",  //
//            @"classification_id" : @"classification_id",//
//            @"satisfaction_level_id" : @"satisfaction_level_id",//
//            @"status_id" : @"status_id",//
//            @"device_info" : @"device_info",//
//            @"official" : @"official",//
//            @"publicaccessable" : @"publicaccessable",//
//            @"app_info" : @"app_info",//
//            @"os_info" : @"os_info",//
//            @"platform" : @"platform",//
//            @"vote" : @"1",
//            @"tags" : @"아야, 어여, 오요,우유"
//        };
//        
//        [helpdesk sendQuestion:(NSDictionary *)param
//                  successBlock:^(void) {
//                      exitRunLoop = YES;
//                  }
//                  failureBlock:^(NSError *error) {
//                      NSLog(@"fail : %@", error.localizedDescription);
//                      STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
//                      exitRunLoop = YES;
//                  }];
//    }
//      failureBlock:^(NSError *error){
//           NSLog(@"fail : %@", error.localizedDescription);
//           STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
//           exitRunLoop = YES;
//      }];
//
//    
//    [self runTestLoop];
//}

- (void)test_4_myList
{
    
    BaasioUser *user = [BaasioUser user];
    user.username = @"helpdesk";
    user.password = @"helpdesk";
    
    [user signInBackground:^(void){
        
        BaasioHelpdesk *helpdesk = [[BaasioHelpdesk alloc]init];
        [helpdesk getMyQuestions:^(NSArray *array) {
            NSLog(@"array : %@", array.description);
            exitRunLoop = YES;
        }
                    failureBlock:^(NSError *error) {
                        NSLog(@"fail : %@", error.localizedDescription);
                        STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                        exitRunLoop = YES;
                    }];
        
    }
              failureBlock:^(NSError *error){
                  NSLog(@"fail : %@", error.localizedDescription);
                  STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                  exitRunLoop = YES;
              }];
    
    
    [self runTestLoop];
}

- (void)test_5_getAnswersList{

    
    BaasioHelpdesk *helpdesk = [[BaasioHelpdesk alloc] init];
    [helpdesk getAnswersList:@"a1f993f7-5950-478c-88d5-39641ce90ea7"
                successBlock:^(NSArray *array) {
                    NSLog(@"array : %@", array.description);
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
