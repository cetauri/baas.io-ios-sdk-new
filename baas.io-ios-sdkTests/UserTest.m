//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserTest.h"
#import "Baasio.h"


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

//- (void)testSignIn
//{
//    BaasioUser *user = [BaasioUser user];
//    user.username = @"username";
//    user.password = @"username";
//
//    [user signInBackground:^(void) {
//                NSLog(@"success");
//                exitRunLoop = YES;
//              }
//              failureBlock:^(NSError *error) {
//                  NSLog(@"fail : %@", error.localizedDescription);
//                  exitRunLoop = YES;
//              }];
//    [self runTestLoop];
//}

- (void)testSignUp
{
    BaasioUser *user = [BaasioUser user];
//    user.username = @"";
//    user.email = @"";
//    user.name = @"";
//    user.password = @"";
//    [user signUp];
    [user signUpInBackground:^(void) {
            NSLog(@"success");
            exitRunLoop = YES;
          }
          failureBlock:^(NSError *error) {
              NSLog(@"fail : %@", error.localizedDescription);
              exitRunLoop = YES;
          }];
        [self runTestLoop];
}

//- (void)testCurrentUser
//{
//    BaasioUser *user = [BaasioUser currtuser];
//}
//
//- (void)testUserInfo{
//    BaasioUser *user = [BaasioUser user];
//}
//
//- (void)testSignOut
//{
//    [BaasioUser signOut];
//}
//

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end