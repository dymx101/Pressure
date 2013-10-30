//
//  RPSinaModel.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPSinaModel.h"

@implementation RPSinaModel


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _accessToken = [jsonDic objectForKey:@"access_token"];
        _uid         = [jsonDic objectForKey:@"uid"];
        _expires_in  = [[jsonDic objectForKey:@"expires_in"]longLongValue];
    }
    return self;
}
@end