//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "BaasioPush.h"

@implementation BaasioPush {

}

- (BaasioRequest*)sendPushInBackground:(BaasioMessage *)config
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = [config dictionary];
    
    return [NetworkManager connectWithHTTP:@"pushes"
                                withMethod:@"POST"
                                    params:params
                                   success:^(id result){
                                       successBlock();
                                   }
                                   failure:failureBlock];
}


- (BaasioRequest*)unregisterInBackground:(void (^)(void))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults]objectForKey:PUSH_DEVICE_ID];
    NSString *path = [@"pushes/devices/" stringByAppendingString:uuid];
    
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"DELETE"
                                    params:nil
                                   success:^(id result){
                                       successBlock();
                                   }
                                   failure:failureBlock];
}

- (BaasioRequest*)registerInBackground:(NSString *)deviceID
                        tags:(NSArray *)tags
                successBlock:(void (^)(void))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock
{
    NSDictionary *params = @{
                                @"platform" : @"I",
                                @"token" : deviceID,
                                @"tags" : tags
                            };
    NSString *path = @"pushes/devices";
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"POST"
                                    params:params
                                   success:^(id result){
                                       NSDictionary *response = (NSDictionary *)result;
                                       
                                       NSDictionary *entity = response[@"entities"][0];
                                       NSString *uuid = [entity objectForKey:@"uuid"];
                                       //                                                                                            NSLog(@"uuid : %@", uuid);
                                       [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:PUSH_DEVICE_ID];
                                       successBlock();
                                   }
                                   failure:failureBlock];

}

@end