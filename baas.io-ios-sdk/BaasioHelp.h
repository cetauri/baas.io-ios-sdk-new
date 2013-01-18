//
//  BaasioHelp.h
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 20..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baasio.h"
#import "BaasioRequest.h"

/**
 A bass.io Framework Help Object.
*/
@interface BaasioHelp : NSObject

/**
 asynchronously 도움말 보기
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)getHelps:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;

/**
 asynchronously 도움말 상세보기
 @param uuid uuid
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)getHelpDetail:(NSString *)uuid
                   successBlock:(void (^)(NSDictionary *dictionary))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

/**
 asynchronously 도움말 검색
 @param keyword keyword
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)searchHelps:(NSString *)keyword
              successBlock:(void (^)(NSArray *array))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;
/**
 asynchronously 문의 리스트보기
 @param param param
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)getQuestions:(NSDictionary *)param
                  successBlock:(void (^)(NSArray *array))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock;
/**
 asynchronously 문의 답변 보기
 @param uuid uuid
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)getAnswers:(NSString *)uuid
                successBlock:(void (^)(NSArray *array))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

/**
 asynchronously 문의 하기
 @param param param
 @param successBlock successBlock
 @param failureBlock failureBlock
*/
- (BaasioRequest*)sendQuestion:(NSDictionary *)param
                   successBlock:(void (^)(void))successBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;
@end
