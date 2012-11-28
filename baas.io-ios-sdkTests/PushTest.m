//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PushTest.h"
#import "BaasioPush.h"

@implementation PushTest {

}
- (void)setUp
{
    [super setUp];

    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}
- (void)testRegisterDevice{
    BaasioPush *push = [[BaasioPush alloc] init];
    [push registerDevice:@"deviceID"];
}

- (void)testUnregisterDevice{

    BaasioPush *push = [[BaasioPush alloc] init];
    [push unregisterDevice:@"uuid"];
}
- (void)testSendPush{
    NSObject *pushConfig = [[NSObject alloc] init];
    BaasioPush *push = [[BaasioPush alloc] init];
    [push sendPush:pushConfig];
}

@end