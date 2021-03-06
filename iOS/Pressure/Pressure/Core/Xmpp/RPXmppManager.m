//
//  LVXmppManager.m
//  Unity-iPhone
//
//  Created by 郑 eason on 13-9-8.
//
//

#import "RPXmppManager.h"
#import "BlockAlertView.h"
#import "RPXmppStream.h"
#import "RPProfile.h"
#import "RPMessage.h"
#import "RPFrChatModel.h"
#import "RPAuthModel.h"
#import "RPXmppProfile.h"
#import "RPAppDelegate.h"
#import "JSON20.h"
#import "RPXmppProfile.h"
#import "RPUtilities.h"
#import "RPAppServerOperation.h"
#import "RPAppModel.h"
#import "RPFrChatModel.h"
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

- (void)sendPing
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (![authModel logined])
    {
        return;
    }
    [_stream sendPingFromUser:authModel.profile.xmppProfile.xmppUserName];
}

- (void)doConnect:(NSString *)xmppUserName xmppPassWord:(NSString *)xmppPassword
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (![authModel logined])
    {
        authModel.userXmppOnline = NO;
        return;
    }
    RPAppDelegate *delegate = (RPAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate enableXmppTimer];
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
    if (success)
    {
        RPAuthModel *authModel = [RPAuthModel sharedInstance];
        authModel.userXmppOnline = YES;
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

- (void)didReceivedIQ
{
    [RPAuthModel sharedInstance].userXmppOnline = YES;
}

- (void)messageReceived:(RPXmppStream *)stream xmppBodyString:(NSString *)xmppBodyString
             typeString:(NSString *)typeString fromJid:(NSString *)fromJid
{
    dispatch_async(dispatch_queue_create("messageReceived", NULL), ^{
        NSDictionary *messageDic = [xmppBodyString JSONValue];
        //如果是神父与倾诉者之间聊天
        if ([[messageDic objectForKey:[RPMessage rpMessageTypeKey]] isEqualToString:RPMessage_Type])
        {
            if (![[RPFrChatModel sharedInstance] checkUserFromMessage:messageDic jid:fromJid])
            {
                return;
            }
            if (![[RPFrChatModel sharedInstance] dealWithFrMessage:messageDic])
            {
                return;
            }
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            long long userId = [messageDic[[RPMessage rpMessageUserIdKey]] longLongValue];
            SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(userInfo, LONGLONG2STR(userId), [RPMessage rpMessageUserIdKey]);
            [RPUtilities runOnMainQueueWithoutDeadlocking:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_XmppTalkingMessage object:nil userInfo:userInfo];
            }];
        }
    });
    
}

- (void)talkerFindFatherPresence:(RPXmppStream *)stream from:(NSString *)from to:(NSString *)to
{
    dispatch_async(dispatch_queue_create("talkerFindFatherPresence", NULL), ^{
        //获取信息后马上添加
        [[RPAppServerOperation sharedRPAppServerOperation] serverCallGetUserProfileByJid:from type:RPChat_VisitUserType_Talker];
//        RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
//        for (RPChat *chat in chatModel.talkerChats)
//        {
//            if ([chat.profile.xmppProfile.xmppUserName isEqualToString:to])
//            {
//                [RPUtilities runOnMainQueueWithoutDeadlocking:^{
//                    BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:@"有人找到你啦" message:@"有人找到你啦"];
//                    [alertView addButtonWithTitle:@"马上聊" block:^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_TalkerFindFather object:nil];
//                    }];
//                    [alertView setCancelButtonWithTitle:@"取消" block:^{
//                        
//                    }];
//                    [alertView show];
//                }];
//                break;
//            }
//        }
    });
}

- (void)FatherFindTalkerPresence:(RPXmppStream *)stream from:(NSString *)from to:(NSString *)to
{
    dispatch_async(dispatch_queue_create("FatherFindTalkerPresence", NULL), ^{
        //获取信息后直接添加
        [[RPAppServerOperation sharedRPAppServerOperation] serverCallGetUserProfileByJid:from type:RPChat_VisitUserType_Father];
        RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
//        for (RPChat *chat in chatModel.fatherChats)
//        {
//            if ([chat.profile.xmppProfile.xmppUserName isEqualToString:to])
//            {
//                [RPUtilities runOnMainQueueWithoutDeadlocking:^{
//                    BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:@"有人找到你啦" message:@"有人找到你啦"];
//                    [alertView addButtonWithTitle:@"好的" block:^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_FatherFindTalker object:nil];
//                    }];
//                    [alertView setCancelButtonWithTitle:@"取消" block:^{
//                        
//                    }];
//                    [alertView show];
//                }];
//                break;
//            }
//        }
    });
}

@end
