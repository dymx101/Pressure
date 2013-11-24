//
//  RPForum.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPForum.h"
#import "RPProfile.h"
#import "RPAudio.h"
#import "RPPicture.h"
#define kId @"id"
#define kText @"text"
#define kStatus @"status"
#define kCreateTime @"create_time"
#define kUpdateTime @"update_time"
#define kChatType   @"chat_type"

@implementation RPForum

- (id)init
{
    self = [super init];
    if (self)
    {
        _picture = [[RPPicture alloc] init];
        _audio   = [[RPAudio alloc] init];
        _profile = [[RPProfile alloc] init];
    }
    return self;
}

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _forum_id = [jsonDic[kId] longLongValue];
        _text = jsonDic[kText];
        _audio = [[RPAudio alloc] initWithJSONDic:jsonDic[kMetaKey_Audio]];
        _picture = [[RPPicture alloc] initWithJSONDic:jsonDic[kMetaKey_Picture]];
        _status = [jsonDic[kStatus] intValue];
        _createTime = [jsonDic[kCreateTime] longLongValue];
        _updateTime = [jsonDic[kUpdateTime] longLongValue];
        _chatType = [jsonDic[kChatType] intValue];
        _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kMetaKey_Profile]];
    }
    return self;
}
@end
