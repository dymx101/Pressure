//
//  LVXmppManager.m
//  Unity-iPhone
//
//  Created by 郑 eason on 13-9-8.
//
//

#import "RPXmppManager.h"
#import "RPXmppStream.h"
static RPXmppManager *lvXmppMnagager = nil;
@interface RPXmppManager () <GCXmppStreamDelegate>
{
    RPXmppStream *_stream;
}

@end
@implementation RPXmppManager


+ (RPXmppManager *)sharedInstance {
    
    if (!lvXmppMnagager) {
        lvXmppMnagager = [[RPXmppManager alloc] init];
        
    }
    return lvXmppMnagager;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _stream        = [RPXmppStream sharedInstance];
        _stream.delegate = self;
    }
    return self;
}

- (void)doConnect:(NSString *)xmppUserName xmppPassWord:(NSString *)xmppPassword
{
    [_stream doConnect:xmppUserName password:xmppPassword];
}


#pragma mark -
#pragma mark XMPPStream Delegate
- (void)didConnectSuccess:(BOOL)success
{
    if (success)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifCenterLoginSuccess object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifCenterLoginFailed object:nil];
    }
}

- (void)presenceError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo
{
    
}

- (void)iqError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo
{
    
}

- (void)messageError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo
{
    
}

- (void)messageReceived:(RPXmppStream *)stream xmppBodyString:(NSString *)xmppBodyString
             typeString:(NSString *)typeString from:(NSString *)fromName
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(userInfo, SAFESTR(xmppBodyString), @"msg");
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifCenterTalkingMessage object:nil userInfo:userInfo];
    [userInfo release];
}

- (void)dealloc
{
    
    [super dealloc];
}

@end
