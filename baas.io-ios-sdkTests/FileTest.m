//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FileTest.h"
#import "BaasioFile.h"
#import "BaasioResponse.h"
@implementation FileTest {

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

- (void)testUpload{
    NSData *data = nil;
    BaasioFile *file = [[BaasioFile alloc] init];
    [file upload:data
         successBlock:^(BaasioResponse *response) {
             NSLog(@"response : %@", response.description);
         }
         failureBlock:^(NSError *error) {
             NSLog(@"error : %@", error.localizedDescription);
         }];
}

- (void)testDownload{

    BaasioFile *file = [[BaasioFile alloc] init];
    [file download:@"1df2de6a-1f40-11e2-83cf-020026de0053"
         successBlock:^(BaasioResponse *response) {
             NSLog(@"response : %@", response.description);
         }
         failureBlock:^(NSError *error) {
             NSLog(@"error : %@", error.localizedDescription);
         }];
}

- (void)testDelete{
    BaasioFile *file = [[BaasioFile alloc] init];
    [file delete:@"1df2de6a-1f40-11e2-83cf-020026de0053"
         successBlock:^(BaasioResponse *response) {
             NSLog(@"response : %@", response.description);
         }
         failureBlock:^(NSError *error) {
             NSLog(@"error : %@", error.localizedDescription);
         }];
}
//- (void)testInfo{
//    BaasioFile *file = [[BaasioFile alloc] init];
//    [file information:@"1df2de6a-1f40-11e2-83cf-020026de0053"
//         successBlock:^(BaasioResponse *response) {
//             NSLog(@"response : %@", response.description);
//         }
//         failureBlock:^(NSError *error) {
//             NSLog(@"error : %@", error.localizedDescription);
//         }];
//}
@end