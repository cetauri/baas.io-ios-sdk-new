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

    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)test_sync_1_SignUp
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri";
    user.email = @"cetauri@gmail.com";
    user.name = @"권오상";
    user.password = @"cetauri";

    NSError *error = nil;
    [user signUp:&error];
    NSLog(@"response : ---------------------- %@", error.localizedDescription );
}

- (void)test_sync_2_SignIn
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri";
    user.password = @"cetauri";
    
    NSError *error = nil;
    [user signIn:&error];
    NSLog(@"response : ---------------------- %@", error.localizedDescription );
}
//- (void)test_1_SignUp
//{
//    BaasioUser *user = [BaasioUser user];
//    user.username = @"cetauri";
//    user.email = @"cetauri@gmail.com";
//    user.name = @"권오상";
//    user.password = @"cetauri";
//
//    [user signUpInBackground:^(void) {
//            NSLog(@"success");
//            exitRunLoop = YES;
//          }
//          failureBlock:^(NSError *error) {
//              NSLog(@"fail : %@", error.localizedDescription);
//              STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
//              exitRunLoop = YES;
//          }];
//        [self runTestLoop];
//}
//
//- (void)test_2_SignIn
//{
//    BaasioUser *user = [BaasioUser user];
//    user.username = @"cetauri";
//    user.password = @"cetauri";
//
//    [user signInBackground:^(void) {
//                    NSLog(@"success");
//                    exitRunLoop = YES;
//              }
//              failureBlock:^(NSError *error) {
//                    NSLog(@"fail : %@", error.localizedDescription);
//                    STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
//
//                    exitRunLoop = YES;
//              }];
//    [self runTestLoop];
//}
//
//
//- (void)test_9_unsubscribe
//{
//    BaasioUser *user = [BaasioUser user];
//    user.username = @"cetauri";
//    [user unsubscribeInBackground:^(void) {
//                            NSLog(@"success");
//                            exitRunLoop = YES;
//                        }
//                      failureBlock:^(NSError *error) {
//                          NSLog(@"fail : %@", error.localizedDescription);
//                          STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
//                          
//                          exitRunLoop = YES;
//                      }];
//    [self runTestLoop];
//}


- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}


- (void)runTestLoopSync{
    NSLog(@"runTestLoopSync");
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];

}
@end