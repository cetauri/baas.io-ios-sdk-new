//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Baasio.h"

@implementation Baasio {

}

+ (id)sharedInstance
{
  static dispatch_once_t pred;
  static id _instance = nil;
  dispatch_once(&pred, ^{
    _instance = [[self alloc] init]; // or some other init method
  });
  return _instance;
}

+ (void)setApplicationInfo:(NSString *)baasioID applicationName:(NSString *)applicationName
{
    NSString *apiURL = @"https://api.baas.io";
    [Baasio setApplicationInfo:apiURL baasioID:baasioID applicationName:applicationName];
}

+ (void)setApplicationInfo:(NSString *)apiURL baasioID:(NSString *)baasioID applicationName:(NSString *)applicationName
{
    Baasio *baasio = [Baasio sharedInstance];
    baasio.apiURL = apiURL;
    baasio.baasioID = baasioID;
    baasio.applicationName = applicationName;
}

- (NSURL *)getAPIURL{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@", _apiURL, _baasioID, _applicationName];
    return [NSURL URLWithString:url];
}

@end