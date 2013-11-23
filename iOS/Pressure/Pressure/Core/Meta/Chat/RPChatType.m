//
//  RPChatType.m
//  Pressure
//
//  Created by eason on 11/17/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPChatType.h"
#define kId @"id"
#define kName @"name"
@implementation RPChatType

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _dbId = [jsonDic[kId] longLongValue];
        _name = jsonDic[kName];
    }
    return self;
}
@end
