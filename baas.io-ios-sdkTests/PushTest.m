//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PushTest.h"
#import "BaasioPush.h"
#import "BaasioPushConfig.h"

@implementation PushTest {
    BOOL exitRunLoop;
}
- (void)setUp
{
    [super setUp];
    exitRunLoop = NO;
    
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)test_1_RegisterDevice{
    BaasioPush *push = [[BaasioPush alloc] init];
    [push registerInBackground:@"0a328b4155e0d423fef64bf949fce997411acc845c0fcb20bb5e33fd8e9944fa"
                          tags:@[@"man",@"adult"]
                  successBlock:^(void) {
                      exitRunLoop = YES;
                  }
                  failureBlock:^(NSError *error) {
                      NSLog(@"fail : %@", error.localizedDescription);
                      STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                      exitRunLoop = YES;
                  }];
    [self runTestLoop];
}

- (void)test_2_sendPush{
    BaasioPush *push = [[BaasioPush alloc] init];
    BaasioPushConfig *config = [[BaasioPushConfig alloc]init];
    config.alert = @"alert";
    config.badge = 10;

    
    [push sendPushInBackground:config
                  successBlock:^(void) {
                      exitRunLoop = YES;
                  }
                  failureBlock:^(NSError *error) {
                      NSLog(@"fail : %@", error.localizedDescription);
                      STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                      exitRunLoop = YES;
                  }];
    [self runTestLoop];
}

- (void)test_3_UnregisterDevice{

    BaasioPush *push = [[BaasioPush alloc] init];
    [push unregisterInBackground:@"b57b118dd15d63595e9d11ae6884766b32ee97d978d78320eb536a506911a40a"
                  successBlock:^(void) {
                      exitRunLoop = YES;
                  }
                  failureBlock:^(NSError *error) {
                      NSLog(@"fail : %@", error.localizedDescription);
                      STFail(@"Test Fail in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                      exitRunLoop = YES;
                  }];
    [self runTestLoop];
}
//- (void)testSendPush{
//    NSObject *pushConfig = [[NSObject alloc] init];
//    BaasioPush *push = [[BaasioPush alloc] init];
//    [push sendPush:pushConfig];
//}

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end