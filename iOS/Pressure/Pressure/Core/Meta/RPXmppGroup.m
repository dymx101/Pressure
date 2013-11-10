//
//  RPXmppGroup.m
//  Pressure
//
//  Created by eason on 11/7/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPXmppGroup.h"
#define kGroupId @"group_id"
#define kGroupName @"group_name"
@implementation RPXmppGroup

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _groupId = [jsonDic[kGroupId] longLongValue];
        _groupName = jsonDic[kGroupName];
    }
    return self;
}
@end
