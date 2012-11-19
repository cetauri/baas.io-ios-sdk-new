//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserTest.h"
#import "Baasio.h"


@implementation UserTest {

}
- (void)setUp
{
    [super setUp];

    [Baasio setApplicationInfo:@"cetauri" applicationName:@"sandbox"];
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)testSignIn
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"cetauri@gmail.com";
    user.password = @"cetauri";
    [user signIn];
//    [user signInBackground:^(void) {
//
//              }
//              failureBlock:^(NSError *error) {
//
//              }
//
//    ];
}

- (void)testSignUp
{
    BaasioUser *user = [BaasioUser user];
    user.username = @"";
    user.email = @"";
    user.name = @"";
    user.password = @"";
    [user signUp];
    [user signUpInBackground:^(void){

                }
                failureBlock:^(NSError *error){

                }];
}

- (void)testCurrentUser
{
    BaasioUser *user = [BaasioUser currtuser];
}

- (void)testUserInfo{
    BaasioUser *user = [BaasioUser user];
}

- (void)testSignOut
{
    [BaasioUser signOut];
}
@end