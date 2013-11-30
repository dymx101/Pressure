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
#define kGender   @"gender"
#define kAge      @"age"
#define kCity     @"city"
#define kUserType @"user_type"
@implementation RPProfile


- (id)init
{
    self = [super init];
    if (self)
    {
        _xmppProfile = [[RPXmppProfile alloc] init];
    }
    return self;
}

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _userId = [jsonDic[kUserId] longLongValue];
        _userName = jsonDic[kUserName];
        _nickName = jsonDic[kNickName];
        _avatarUrl = jsonDic[kAvatarUrl];
        _city = jsonDic[kCity];
        _age = [jsonDic[kAge] intValue];
        _gender = [jsonDic[kGender] intValue];
        _xmppProfile = [[RPXmppProfile alloc]initWithJSONDic:jsonDic[kMetaKey_XmppProfile]];
        
    }
    return  self;
}

- (NSString *)genderStr
{
    switch (_gender) {
        case RPProfile_Gender_Female:
        {
            return @"女";
        }
            break;
        case RPProfile_Gender_Male:
        {
            return @"男";
        }
            break;
        default:
            break;
    }
    return nil;
}


@end
