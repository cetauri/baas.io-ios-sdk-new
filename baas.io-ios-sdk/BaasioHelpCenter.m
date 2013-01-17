//
//  BaasioHelpCenter.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 20..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "BaasioHelpCenter.h"
#import "BaasioNetworkManager.h"
@implementation BaasioHelpCenter




- (BaasioRequest*)getHelps:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{

    return [self searchHelps:@"" successBlock:successBlock failureBlock:failureBlock];
}

- (BaasioRequest*)searchHelps:(NSString *)keyword
              successBlock:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock
{

    NSDictionary *param = @{@"keyword": keyword};
    
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:@"help/helps"
                                                           withMethod:@"GET"
                                                               params:param
                                                              success:^(id result){
                                                                  NSDictionary *response = (NSDictionary *)result;
                                                                  NSLog(@"response : %@", response);
                                                                  NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                                                  successBlock(objects);
                                                              }
                                                              failure:failureBlock];

}

- (BaasioRequest*)getHelpDetail:(NSString *)uuid
                    successBlock:(void (^)(NSDictionary *dictionary))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock{
    
    NSString *path = [@"help/helps/" stringByAppendingString:uuid];
    
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                       withMethod:@"GET"
                                                           params:nil
                                                          success:^(id result){
                                                              NSDictionary *response = (NSDictionary *)result;
                                                              NSLog(@"response : %@", response);
                                                              NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                                              successBlock(objects[0]);
                                                          }
                                                          failure:failureBlock];
}


- (BaasioRequest*)getAnswers:(NSString *)uuid
                successBlock:(void (^)(NSArray *array))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock{

    NSString *path = [NSString stringWithFormat:@"help/questions/%@/answers", uuid];
    
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                       withMethod:@"GET"
                                                           params:nil
                                                          success:^(id result){
                                                              NSDictionary *response = (NSDictionary *)result;
                                                              NSLog(@"response : %@", response);
                                                              NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                                              successBlock(objects);
                                                          }
                                                          failure:failureBlock];
}

//문의 리스트보기
- (BaasioRequest*)getQuestions:(NSDictionary *)param
                  successBlock:(void (^)(NSArray *array))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock
{
    
    NSString *path = @"help//questions/my_list";
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                       withMethod:@"GET"
                                                           params:param
                                                          success:^(id result){
                                                              NSDictionary *response = (NSDictionary *)result;
                                                              NSLog(@"response : %@", response);
                                                              NSArray *objects = [NSArray arrayWithArray:response[@"entities"]];
                                                              successBlock(objects);
                                                          }
                                                          failure:failureBlock];
}

//문의 하기
- (BaasioRequest*)sendQuestion:(NSDictionary *)param
                  successBlock:(void (^)(void))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock
{
    NSString *path = @"help/questions";
    return [[BaasioNetworkManager sharedInstance] connectWithHTTP:path
                                                       withMethod:@"POST"
                                                           params:param
                                                          success:^(id result){
                                                              NSDictionary *response = (NSDictionary *)result;
                                                              NSLog(@"response : %@", response);
                                                              successBlock();
                                                          }
                                                          failure:failureBlock];
}


@end
