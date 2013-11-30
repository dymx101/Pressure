//
//  RPXmppStream.m
//  GameChat
//
//  Created by zys on 13-1-17.
//  Copyright (c) 2013年 Ruoogle. All rights reserved.
//

#import "RPXmppStream.h"
#import "XMPP.h"
#import "NSString+TomAddition.h"

#define kElement_Body      @"body"
#define kElement_From      @"from"
#define kElement_To        @"to"
#define kElement_Msg       @"msg"
#define kElement_Sender    @"sender"
#define kElement_Xmlns     @"xmlns"
#define kElement_Message   @"message"
#define kElement_Type      @"type"
#define kElement_Composing @"composing"
#define kElement_Pause     @"paused"
#define kElement_Inactive  @"inactive"

#define kElement_MatchType     @"match_type"

#define kElement_XmlnsDefault     @"jabber:client"
#define kElement_PresenceType_Unavaliable @"Unavailable"
#define kElement_PresenceType_Avaliable @"Available"
#define kElement_PresenceType_FreeToChat @"chat"
#define kElement_PresenceType_Subscribe @"subscribe"
#define kElement_PresenceType_Subscribed @"subscribed"
#define kElement_PresenceType_UnSubscribed @"unsubscribe"
#define kElement_PresenceType_Error        @"error"


#define kElement_MessageType_chat       @"chat"
#define kElement_MessageType_groupChat  @"groupchat"

@interface RPXmppStream () {
    XMPPStream *_xmppStream;
    BOOL _isOpen;
}

@property (nonatomic, copy) NSString *password;

@end;

static RPXmppStream *rpXmppStream = nil;

@implementation RPXmppStream

+ (RPXmppStream *)sharedInstance {
    
    if (!rpXmppStream) {
        rpXmppStream = [[RPXmppStream alloc] init];
    }
    return rpXmppStream;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        _xmppStream = [[XMPPStream alloc] init];
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_current_queue()];
    }
    
    return self;
}

- (void)sendOnlineStatus
{
    //发送在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    NSXMLElement *status = [NSXMLElement elementWithName:@"status"];
    [status setStringValue:kElement_PresenceType_Avaliable];
    [presence addChild:status];
    [_xmppStream sendElement:presence];
}

- (void)sendPingFromUser:(NSString *)from_UserName {

  XMPPIQ *iq = [XMPPIQ iqWithType:@"get"];
  NSXMLElement *ping = [NSXMLElement elementWithName:@"ping" xmlns:@"urn:xmpp:ping"];
  [iq addChild:ping];
  [iq addAttributeWithName:kElement_From stringValue:from_UserName];
  [_xmppStream sendElement:iq];
}

- (void)sendofflineStatus {
    
    //发送下线状态
    XMPPPresence *presence = [XMPPPresence presence];
    NSXMLElement *status = [NSXMLElement elementWithName:@"status"];
    [status setStringValue:kElement_PresenceType_Unavaliable];
    [presence addChild:status];
    [_xmppStream sendElement:presence];
}

- (BOOL)doConnect:(NSString *)name password:(NSString *)password{
    
    if (![_xmppStream isDisconnected])
    {
        if ([_delegate respondsToSelector:@selector(didConnectSuccess:)])
        {
            [_delegate didConnectSuccess:YES];
        }
        return YES;
    }
    
    if (!name || !password) {
        return NO;
    }
    
    //设置用户
    [_xmppStream setMyJID:[XMPPJID jidWithString:name]];
    
    //设置服务器
    [_xmppStream setHostName:kXMPPHost];
    
    self.password = password;
    //连接服务器
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:10.0 error:&error]) {
        if ([_delegate respondsToSelector:@selector(didConnectSuccess:)])
        {
            [_delegate didConnectSuccess:NO];
        }
        return NO;
    }
    
    return YES;
}

- (void)disConnect {
    
    [_xmppStream disconnect];
}

- (void)disConnectAfterSending {
    
    [_xmppStream disconnectAfterSending];
}

- (void)sendMessage:(NSString *)message toName:(NSString *)to_userName fromName:(NSString *)from_userName {
    
    XMPPMessage *mes = [[XMPPMessage alloc] initWithType:kElement_MessageType_chat to:[XMPPJID jidWithString:to_userName] elementID:from_userName];
    
    [mes addBody:message];
    
    [_xmppStream sendElement:mes];
}



#pragma mark XMPPStreamDelegate
- (XMPPIQ *)xmppStream:(XMPPStream *)sender willSendIQ:(XMPPIQ *)iq
{
    MLOG(@"XMPPStreamDelegate:willSendIQ%@",[iq XMLString]);
    return iq;
}
- (XMPPMessage *)xmppStream:(XMPPStream *)sender willSendMessage:(XMPPMessage *)message
{
    MLOG(@"XMPPStreamDelegate:willSendMessage%@",[message XMLString]);
    return message;
}
- (XMPPPresence *)xmppStream:(XMPPStream *)sender willSendPresence:(XMPPPresence *)presence
{
    MLOG(@"XMPPStreamDelegate:willSendPresence%@",[presence XMLString]);
    return presence;
}
//连接服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    if ([_delegate respondsToSelector:@selector(didConnectSuccess:)])
    {
        [_delegate didConnectSuccess:YES];
    }
    _isOpen = YES;
    NSError *error = nil;
    //验证密码
    [_xmppStream authenticateWithPassword:self.password error:&error];
}

//验证通过
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    if ([_delegate respondsToSelector:@selector(didAuthSuccess:)]) {
        [_delegate didAuthSuccess:YES];
    }
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    MLOG(@"/*********** didNotAuthenticate %@ ***********/",error);
    if ([_delegate respondsToSelector:@selector(didAuthSuccess:)]) {
        [_delegate didAuthSuccess:NO];
    }
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    
    NSString *body = [[message elementForName:kElement_Body] stringValue];
    NSString *from = [[message attributeForName:kElement_From] stringValue];
    NSString *type = [[message attributeForName:kElement_Type] stringValue];
//    NSXMLElement *composing = [message elementForName:kElement_Composing];
//    NSXMLElement *pause = [message elementForName:kElement_Pause];
//    NSXMLElement *error = nil;
//    
//    if (error) {
//        
//        if ([error attributeForName:kRPXmppErrorCode]) {
//            
//            int errorCode = [error attributeInt32ValueForName:kRPXmppErrorCode];
//            NSString *errorMessage = [error attributeStringValueForName:kRPXmppErrorMessage withDefaultValue:@""];
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//            SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, errorMessage, kRPXmppErrorMessage);
//            SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(dic, body, kRPXmppErrorUserInfoBody);
//            [self.delegate messageError:self errorCode:errorCode userInfo:dic];
//        }
//        return;
//    }
//    
//    if ((!body || !from || !type) && !composing && !pause) {
//        return;
//    }
//    
    
    if (body != nil) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:body forKey:kElement_Msg];
//        [dic setObject:from forKey:kElement_Sender];
        if (self.delegate && [self.delegate respondsToSelector:@selector(messageReceived:xmppBodyString:typeString:fromJid:)]) {
            [self.delegate messageReceived:self xmppBodyString:body typeString:type fromJid:from];
        }
    }
//    else if (composing != nil) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(messageReceivedComposing:from:)]) {
//            [self.delegate messageReceivedComposing:self from:from];
//        }
//        
//    } else if (pause != nil) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(messageReceivedPause:from:)]) {
//            [self.delegate messageReceivedPause:self from:from];
//        }
//        
//    }
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq {
    
    if ([self.delegate respondsToSelector:@selector(didReceivedIQ)])
    {
        [self.delegate didReceivedIQ];
    }
    
    return YES;
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    
    //取得好友状态
    NSString *presenceType = [presence type];
    //当前用户
    NSString *toUserName = [[sender myJID] user];
    //在线用户
    NSString *fromUserName = [[presence from] user];
    
    if ([[presence status] isEqualToString:@"talker_find_father"])
    {
        if ([self.delegate respondsToSelector:@selector(talkerFindFatherPresence:from:to:)])
        {
            [self.delegate talkerFindFatherPresence:self from:fromUserName to:toUserName];
        }
        return;
    }else if ([[presence status] isEqualToString:@"father_find_talker"])
    {
        if ([self.delegate respondsToSelector:@selector(FatherFindTalkerPresence:from:to:)])
        {
            [self.delegate FatherFindTalkerPresence:self from:fromUserName to:toUserName];
        }
    }
    
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(NSXMLElement *)error
{
    NSLog(@"");
}

- (void)sendComposing:(NSString *)to_userName fromName:(NSString *)from_userName fromDevice:(NSString *)device {
    
    NSXMLElement *mes = [NSXMLElement elementWithName:kElement_Message];
    
    //消息类型
    [mes addAttributeWithName:kElement_Type stringValue:kElement_MessageType_chat];
    //发送给谁
    [mes addAttributeWithName:kElement_To stringValue:to_userName];
    //由谁发送
    [mes addAttributeWithName:kElement_From stringValue:from_userName];
    
    NSXMLElement *body = [NSXMLElement elementWithName:kElement_Composing];
    
    [mes addChild:body];
    [_xmppStream sendElement:mes];
    
}

- (void)sendPause:(NSString *)to_userName fromName:(NSString *)from_userName {
    
    NSXMLElement *mes = [NSXMLElement elementWithName:kElement_Message];
    
    //消息类型
    [mes addAttributeWithName:kElement_Type stringValue:kElement_MessageType_chat];
    //发送给谁
    [mes addAttributeWithName:kElement_To stringValue:to_userName];
    //由谁发送
    [mes addAttributeWithName:kElement_From stringValue:from_userName];
    
    NSXMLElement *body = [NSXMLElement elementWithName:kElement_Pause];
    
    [mes addChild:body];
    [_xmppStream sendElement:mes];
}



- (BOOL)isDisconnedted {
    
    return [_xmppStream isDisconnected];
}


@end
