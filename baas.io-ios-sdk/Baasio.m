//
// Created by cetauri on 12. 11. 19..
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Baasio.h"

static NSString * _apiURL;
static NSString * _applicationName;
static NSString * _orgName;
@implementation Baasio {

}
+ (void)setApplicationInfo:(NSString *)orgName applicationName:(NSString *)applicationName{
    _apiURL = @"https://api.baas.io";
    [Baasio setApplicationInfo:_apiURL organizationName:orgName applicationName:applicationName];

}

+ (void)setApplicationInfo:(NSString *)apiURL organizationName:(NSString *)orgName applicationName:(NSString *)applicationName
{
    _apiURL = apiURL;
    _applicationName = applicationName;
    _orgName = orgName;
}

//static BaasClient *instance = nil;
+ (id) createInstance{
    Baasio *baasIO = [[Baasio alloc] init];
    return baasIO;
}

- (NSString *)getAppInfo{
    NSString *info = [NSString stringWithFormat:@"%@/%@", _orgName, _applicationName];
    return info;
}

- (NSString *)getAPIURL{
    return [NSString stringWithFormat:@"%@/%@", self.getAPIHost, self.getAppInfo];
}

- (NSString *)getAPIHost{
    return _apiURL;
}
-(id)init
{
    if (self = [super init])
    {
        NSString *applicationID = [self getAppInfo];
        NSString *baseURL = [self getAPIHost];
    }
    return self;
}
@end