//
//  LVXmppManager.m
//  Unity-iPhone
//
//  Created by 郑 eason on 13-9-8.
//
//

#import "RPXmppManager.h"
#import "RPXmppStream.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
#import "RPXmppProfile.h"
static RPXmppManager *lvXmppMnagager = nil;
@interface RPXmppManager () <RPXmppStreamDelegate>
{
    RPXmppStream *_stream;
}

@end
@implementation RPXmppManager


+ (RPXmppManager *)sharedInstance {
    
    if (!lvXmppMnagager)
    {
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

- (void)sendOnlineStatus:(User_Xmpp_OnlineStatus)status
{
    switch (status) {
        case User_Xmpp_OnlineStatus_Online:
        {
            [_stream sendOnlineStatus];
        }
            break;
        case User_Xmpp_OnlineStatus_Offline:
        {
            [_stream sendofflineStatus];
        }
            break;
            
        default:
            break;
    }
}

- (void)sendMessage:(NSString *)message toUser:(RPXmppProfile *)toUser
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (!authModel || !authModel.profile || !authModel.profile.xmppProfile)
    {
        return;
    }
    RPXmppProfile *xmppProfile = authModel.profile.xmppProfile;
    [_stream sendMessage:message toName:[toUser jID] fromName:[xmppProfile jID]];
}
#pragma mark -
#pragma mark XMPPStream Delegate
- (void)didConnectSuccess:(BOOL)success
{
    if (!success)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_XmppConnectSuccess object:nil];
    }
}

- (void)didAuthSuccess:(BOOL)success
{
    if (success)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_XmppLoginSuccess object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_XmppLoginFailed object:nil];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_XmppTalkingMessage object:nil userInfo:userInfo];
}


@end
