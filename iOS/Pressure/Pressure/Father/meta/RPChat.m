//
//  RPChat.m
//  Pressure
//
//  Created by eason on 11/22/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPChat.h"
#import "RPProfile.h"
#define kChatId @"chat_id"
#define kUserType @"user_type"
@implementation RPChat

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _userType = [[jsonDic objectForKey:kUserType] intValue];
        if (_userType == RPChat_VisitUserType_Father)
        {
            _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kMetaKey_Father_Profile]];
        }else if (_userType == RPChat_VisitUserType_Talker)
        {
            _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kMetaKey_Talker_Profile]];
        }
        
        _chat_id = [[jsonDic objectForKey:kChatId] longLongValue];
        
    }
    return self;
}

@end
