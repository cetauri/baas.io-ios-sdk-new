//
// Created by cetauri on 12. 11. 26..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BaasioResponse : NSDictionary
@property (strong)NSError *error;
@property (strong)NSDictionary *response;


@end