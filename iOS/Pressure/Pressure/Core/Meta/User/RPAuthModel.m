//
//  RPAuthModel.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAuthModel.h"
#import "RPProfile.h"
#import "RPThirdModel.h"
#import "RPXmppProfile.h"
#import "RPSession.h"
static RPAuthModel * authModel = nil;
@implementation RPAuthModel


+ (RPAuthModel *)sharedInstance
{
    if (authModel == nil)
    {
        authModel = [[RPAuthModel alloc] init];
    }
    return  authModel;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _profile = [[RPProfile alloc] init];
        _session = [[RPSession alloc] init];
        _thirdModel = [[RPThirdModel alloc] init];
        _xmppProfile = [[RPXmppProfile alloc] init];
    }
    return self;
}

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _profile = [[RPProfile alloc] init];
        _session = [[RPSession alloc] init];
        _thirdModel = [[RPThirdModel alloc] init];
        _xmppProfile = [[RPXmppProfile alloc] init];
    }
    return self;
}


- (void)setLoginSuccValue:(NSDictionary *)jsonDic
{
    
    _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kMetaKey_Profile]];
    _session = [[RPSession alloc] initWithJSONDic:jsonDic[kMetaKey_Session]];
    _xmppProfile = [[RPXmppProfile alloc] initWithJSONDic:jsonDic[kMetaKey_XmppProfile]];
    
}

- (NSDictionary *)proxyForJson
{
    return [NSDictionary dictionary];
}

- (void)setWithJSONDic:(NSDictionary *)dic
{
    
    //子类继承
}


- (BOOL)logined
{
    if (_session && _session.refreshToken && ![_session.refreshToken isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}


- (BOOL)serverLogined
{
    return YES;
}
@end
