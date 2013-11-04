//
//  RPXmppProfile.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPXmppProfile.h"
#define kXmppUserName @"xmpp_user_name"
#define kSecretKey    @"secret_key"
#define kDomain         @"domain"
@implementation RPXmppProfile

-(id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _xmppUserName = jsonDic[kXmppUserName];
        _secretKey = jsonDic[kSecretKey];
        _domain = jsonDic[kDomain];
    }
    return self;
}


- (NSString *)jID
{
    return [NSString stringWithFormat:@"%@@%@",_xmppUserName,_domain];
}

- (NSString *)password
{
    return [NSString stringWithFormat:@"%@%@",_xmppUserName,_secretKey];
}



@end
