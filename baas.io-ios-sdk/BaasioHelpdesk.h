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


//도움말 보기
- (BaasioRequest*)getHelps:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;


//도움말 상세보기
- (BaasioRequest*)getHelpDetail:(NSString *)uuid
                   successBlock:(void (^)(NSDictionary *dictionary))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

//도움말 검색
- (BaasioRequest*)searchHelps:(NSString *)keyword
              successBlock:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;

//문의 리스트보기
- (BaasioRequest*)getQuestions:(NSDictionary *)param
                  successBlock:(void (^)(NSArray *array))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock;

//문의 답변 보기
- (BaasioRequest*)getAnswers:(NSString *)uuid
                successBlock:(void (^)(NSArray *array))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

//문의 하기
- (BaasioRequest*)sendQuestion:(NSDictionary *)param
                   successBlock:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

@end
