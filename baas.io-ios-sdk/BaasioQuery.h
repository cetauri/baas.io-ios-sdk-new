//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BaasioEntity.h"


@interface BaasioQuery : NSObject
+ (BaasioQuery *)queryWithEntityName:(NSString *)string;

- (BaasioEntity *)entitytWithID:(NSString *)string;

@end