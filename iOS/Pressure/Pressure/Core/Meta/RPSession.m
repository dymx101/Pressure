//
//  RPSession.m
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPSession.h"

#define kRefreshToken @"refresh_token"
#define kExpireIn       @"expire_in"
@implementation RPSession


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _refreshToken = jsonDic[kRefreshToken];
        _expire_in  = [jsonDic[kExpireIn] longLongValue];
    }
    return self;
}
@end
