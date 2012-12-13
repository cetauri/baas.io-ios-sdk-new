//
//  BaasioGroup.m
//  baas.io-ios-sdk
//
//  Created by cetauri on 12. 12. 11..
//  Copyright (c) 2012년 kth. All rights reserved.
//

#import "BaasioGroup.h"

@implementation BaasioGroup{
    //XXX User객체?
    NSString *_user;
    NSString *_group;
}

-(id) init
{
    self = [super init];
    if (self){
        self.entityName = @"groups";
    }
    return self;
}


- (void)setGroupName:(NSString*)group{
    _group = group;
    
}
- (void)setUserName:(NSString*)user{
    _user = user;
}

- (BaasioRequest*)createInBackground:(void (^)(BaasioGroup *group))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock{
    return [super saveInBackground:^(BaasioEntity *entity){
                    BaasioGroup *group = [[BaasioGroup alloc]init];
                    [group setEntity:entity.dictionary];
                    successBlock(group);
                }
               failureBlock:failureBlock];
}


- (BaasioRequest*)updateInBackground:(void (^)(BaasioGroup *group))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock
{
    return [super updateInBackground:^(BaasioEntity *entity){
                            BaasioGroup *group = [[BaasioGroup alloc]init];
                            [group setEntity:entity.dictionary];
                            successBlock(group);
                        }
                        failureBlock:failureBlock];
}


//- (void)delete:(NSError **)error;
- (BaasioRequest*)deleteInBackground:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock{
    {
        return [super deleteInBackground:^(void){
                                successBlock();
                            }
                            failureBlock:failureBlock];
    }
}


//- (void)add:(NSError **)error;
- (BaasioRequest*)addInBackground:(void (^)(BaasioGroup *group))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock{

    NSString *path = [NSString stringWithFormat:@"groups/%@/users/%@", _group, _user];
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"POST"
                                    params:nil
                                   success:^(id result){
                                       NSDictionary *dictionary = result[@"entities"][0];
                                       
                                       BaasioGroup *group = [[BaasioGroup alloc]init];
                                       [group setEntity:dictionary];
                                       successBlock(group);
                                       
                                   }
                                   failure:failureBlock];
}
//- (void)remove:(NSError **)error;
- (BaasioRequest*)removeInBackground:(void (^)(void))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock{

    NSString *path = [NSString stringWithFormat:@"groups/%@/users/%@", _group, _user];
    return [NetworkManager connectWithHTTP:path
                                withMethod:@"DELETE"
                                    params:nil
                                   success:^(id result){
                                       successBlock();
                                   }
                                   failure:failureBlock];
}

@end
