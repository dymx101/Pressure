//
//  RPProfile.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPProfile.h"
#define kUserId @"user_id"
#define kUserName @"user_name"
@implementation RPProfile


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _userId = [jsonDic[kUserId] longLongValue];
        _userName = jsonDic[kUserName];
    }
    return  self;
}
@end
