//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FileTest.h"
#import "BaasioFile.h"
#import "BaasioResponse.h"
@implementation FileTest {
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

- (void)test_1_Upload{
    NSData *data = [@"Working at Parse is great!" dataUsingEncoding:NSUTF8StringEncoding];
    BaasioFile *file = [[BaasioFile alloc] init];
    [file uploadInBackground:data
                successBlock:^(void) {
                     NSLog(@"success");
                    exitRunLoop = YES;
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"error : %@", error.localizedDescription);
                    exitRunLoop = YES;
                }
                progressBlock:^(float progress){
                    NSLog(@"progress : %f", progress);
                }
     ];
    NSLog(@"testInfo : %@", file.description);

}

//- (void)testDownload{
//
//    BaasioFile *file = [[BaasioFile alloc] init];
//    [file download:@"1df2de6a-1f40-11e2-83cf-020026de0053"
//         successBlock:^(BaasioResponse *response) {
//             NSLog(@"response : %@", response.description);
//         }
//         failureBlock:^(NSError *error) {
//             NSLog(@"error : %@", error.localizedDescription);
//         }];
//}
//
//- (void)testDelete{
//    BaasioFile *file = [[BaasioFile alloc] init];
//    [file delete:@"1df2de6a-1f40-11e2-83cf-020026de0053"
//         successBlock:^(BaasioResponse *response) {
//             NSLog(@"response : %@", response.description);
//         }
//         failureBlock:^(NSError *error) {
//             NSLog(@"error : %@", error.localizedDescription);
//         }];
//}

- (void)testInfo{
    BaasioFile *file = [[BaasioFile alloc] init];
    [file informationInBackground:@"42a2aaed-3d24-11e2-95a4-0200554d0016"
         successBlock:^(void) {
             NSLog(@"success");
             exitRunLoop = YES;
         }
         failureBlock:^(NSError *error) {
             NSLog(@"error : %@", error.localizedDescription);
             exitRunLoop = YES;

         }];
    [self runTestLoop];
    NSLog(@"testInfo : %@", file.description);
}

- (void)runTestLoop{
    while (!exitRunLoop){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}
@end