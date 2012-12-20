//
//  BaasioHelpdesk.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 20..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baasio.h"
#import "BaasioRequest.h"
@interface BaasioHelpdesk : NSObject



- (BaasioRequest*)getHelpList:(NSString *)query
                 successBlock:(void (^)(NSArray *array))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

- (BaasioRequest*)getHelpDetail:(NSString *)uuid
                   successBlock:(void (^)(NSDictionary *dictionary))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

//문의 답변 보기
- (BaasioRequest*)getAnswersList:(NSString *)uuid
                          successBlock:(void (^)(NSArray *array))successBlock
                          failureBlock:(void (^)(NSError *error))failureBlock;

//문의 리스트보기
- (BaasioRequest*)getMyQuestions:(void (^)(NSArray *array))successBlock
                            failureBlock:(void (^)(NSError *error))failureBlock;

//문의 하기
- (BaasioRequest*)sendQuestion:(NSDictionary *)param
                   successBlock:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

@end
