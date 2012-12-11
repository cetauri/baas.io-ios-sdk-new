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
//    [super setUp];
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
    file.data = data;
    file.options = nil;
    [file uploadInBackground:^(BaasioFile *file) {
                    NSLog(@"success : %@", file.uuid);

                    [[NSUserDefaults standardUserDefaults]setObject:file.uuid forKey:@"file.uuid"];
                    exitRunLoop = YES;
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"error : %@", error.localizedDescription);
                    
                    STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                    exitRunLoop = YES;
                }
                progressBlock:^(float progress){
                    NSLog(@"progress : %f", progress);
                }
     ];
    
    [self runTestLoop];
}

- (void)test_2_Info{
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults]objectForKey:@"file.uuid"];
    
    BaasioFile *file = [[BaasioFile alloc] init];
    file.uuid = uuid;
    [file informationInBackground:^(BaasioFile *file) {
                         NSLog(@"success : %@", file.description);
                         exitRunLoop = YES;
                     }
                     failureBlock:^(NSError *error) {
                         NSLog(@"error : %@", error.localizedDescription);
                         STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                         exitRunLoop = YES;
                     }];
    
    [self runTestLoop];
}


- (void)test_3_Download{
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults]objectForKey:@"file.uuid"];
    
    NSString *path = [NSString stringWithFormat:@"%@/1.txt", NSTemporaryDirectory()];
    BaasioFile *file = [[BaasioFile alloc] init];
    file.uuid = uuid;
    file.downloadPath = path;
    [file downloadInBackground:^(NSString *downloadPath) {
                      NSLog(@"success : %@", downloadPath);
                      // 파일 읽기.
                      NSString *entireFileInString = [NSString stringWithContentsOfFile:downloadPath encoding:NSStringEncodingConversionAllowLossy error:nil];
                      // 라인별로 읽기.
                      NSArray *lines = [entireFileInString componentsSeparatedByString:@"\n"];
                      // 테스트.
                      for (NSString *line in lines) {
                          NSLog(@"%@",[NSString stringWithFormat:@"line: %@", line]);
                      }
                      
                      exitRunLoop = YES;
                 }
                 failureBlock:^(NSError *error) {
                     NSLog(@"error : %@", error.localizedDescription);
                     
                     STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
                 }
                 progressBlock:^(float progress){
                     NSLog(@"progress : %f", progress);   
                 }
             ];
}


- (void)test_4_Delete{
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults]objectForKey:@"file.uuid"];
    
    BaasioFile *file = [[BaasioFile alloc] init];
    file.uuid = uuid;
    [file deleteInBackground:^(void) {
                    NSLog(@"Delete success.");
                    exitRunLoop = YES;
                }
                failureBlock:^(NSError *error) {
                    NSLog(@"error : %@", error.localizedDescription);
                    STFail(@"Test Faiil in %@ : %@", NSStringFromSelector(_cmd), error.localizedDescription);
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