//
//  HelpDeskTest.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 20..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "HelpDeskTest.h"
#import "BaasioHelpdesk.h"
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


- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
//
//- (BaasioRequest*)getHelpDetail:(NSString *)uuid
//                   successBlock:(void (^)(NSDictionary *dictionary))successBlock
//                   failureBlock:(void (^)(NSError *error))failureBlock;
//
////문의 답변 보기
//- (BaasioRequest*)getAnswersList:(NSString *)uuid
//                    successBlock:(void (^)(NSArray *array))successBlock
//                    failureBlock:(void (^)(NSError *error))failureBlock;
//
////문의 리스트보기
//- (BaasioRequest*)getMyQuestions:(void (^)(NSArray *array))successBlock
//                    failureBlock:(void (^)(NSError *error))failureBlock;
//
////문의 하기
//- (BaasioRequest*)sendQuestion:(NSDictionary *)param
//                  successBlock:(void (^)(void))successBlock
//                  failureBlock:(void (^)(NSError *error))failureBlock;
@end
