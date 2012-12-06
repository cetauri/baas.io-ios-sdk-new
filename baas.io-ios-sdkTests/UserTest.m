//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserTest.h"
#import "Baasio.h"
#import "BaasioUser.h"

@implementation UserTest {
    BOOL exitRunLoop;
}

- (void)setUp
{
    [super setUp];
    exitRunLoop = NO;

//    [Baasio setApplicationInfo:@"https://api.usergrid.com/" baasioID:@"c3e0fa60-0162-11e2-bf27-12313b0c5ebb" applicationName:@"sandbox"];
    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
    
//    [Baasio setApplicationInfo:@"http://localhost:8080/" baasioID:@"test.push" applicationName:@"sandbox"];
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}


- (void)test_1_SignUp
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri";
    user.email = @"cetauri@gmail.com";
    user.name = @"권오상";
    user.password = @"cetauri";

    [user signUpInBackground:^(void) {
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

- (void)test_2_SignIn
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri";
    user.password = @"cetauri";

    [user signInBackground:^(void) {
                    NSLog(@"success");
                    exitRunLoop = YES;
              }
              failureBlock:^(NSError *error) {
                    NSLog(@"fail : %@", error.localizedDescription);

                    exitRunLoop = YES;
                    STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
              }];
    [self runTestLoop];
}


- (void)test_9_unsubscribe
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri";
    [user unsubscribeInBackground:^(void) {
        NSLog(@"success");
        exitRunLoop = YES;
    }
              failureBlock:^(NSError *error) {
                  NSLog(@"fail : %@", error.localizedDescription);
                  
                  exitRunLoop = YES;
                  STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
              }];
    [self runTestLoop];
}


- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end