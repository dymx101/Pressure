//
//  RPProfile.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPProfile.h"
#import "RPXmppProfile.h"
#import "RPMetaKeyDef.h"
#define kUserId @"user_id"
#define kUserName @"user_name"
#define kNickName @"nick_name"
#define kAvatarUrl @"avatar_url"
@implementation RPProfile


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _userId = [jsonDic[kUserId] longLongValue];
        _userName = jsonDic[kUserName];
        _nickName = jsonDic[kNickName];
        _avatarUrl = jsonDic[kAvatarUrl];
        _xmppProfile = [[RPXmppProfile alloc]initWithJSONDic:jsonDic[kMetaKey_XmppProfile]];
    }
    return  self;
}


@end
