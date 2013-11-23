//
//  RPXmppStream.h
//  GameChat
//
//  Created by zys on 13-1-17.
//  Copyright (c) 2013年 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPStream.h"



#define kRPXmppErrorCode    @"errorcode"
#define kRPXmppErrorMessage @"errormessage"
#define kRPXmppErrorUserInfoBody @"body"


@class RPXmppStream;

@protocol RPXmppStreamDelegate <NSObject>
@optional

//- (void)friendOnlineMessage:(RPXmppStream *)stream user:(RPUser *)user;

//- (void)friendOfflineMessage:(RPXmppStream *)stream user:(RPUser *)user;

- (void)addFriendMessage:(RPXmppStream *)stream toUserName:(NSString *)toUserName fromUserName:(NSString *)fromUserName returnDic:(NSDictionary *)returnDic;

- (void)deleteMeMessage:(RPXmppStream *)stream toUserName:(NSString *)toUserName fromUserName:(NSString *)fromUserName returnDic:(NSDictionary *)returnDic;

- (void)myDeleteReceivedMessage:(RPXmppStream *)stream toUserName:(NSString *)toUserName fromUserName:(NSString *)fromUserName returnDic:(NSDictionary *)returnDic;

- (void)talkerFindFatherPresence:(RPXmppStream *)stream from:(NSString *)from to:(NSString *)to;

- (void)messageReceived:(RPXmppStream *)stream xmppBodyString:(NSString *)xmppBodyString
             typeString:(NSString *)typeString from:(NSString *)fromName;

- (void)messageReceivedComposing:(RPXmppStream *)stream from:(NSString *)fromName;

- (void)messageReceivedPause:(RPXmppStream *)stream from:(NSString *)fromName;

- (void)offlinePresenceReceived:(RPXmppStream *)stream fromUserName:(NSString *)fromUserName;

// 当doConnect成功的时候调用
- (void)didAuthSuccess:(BOOL)success;
- (void)didConnectSuccess:(BOOL)success;

- (void)presenceError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo;
- (void)iqError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo;
- (void)messageError:(RPXmppStream *)stream errorCode:(int)errorCode userInfo:(NSDictionary *)userInfo;

@end

@interface RPXmppStream : NSObject


@property (nonatomic, assign) id <RPXmppStreamDelegate> delegate;


+ (RPXmppStream *)sharedInstance;

- (BOOL)isDisconnedted;

//发送在线状态
- (void)sendOnlineStatus;

//发送下线状态
- (void)sendofflineStatus;

//发送ping
- (void)sendPingFromUser:(NSString *)from_UserName;

//尝试连接
- (BOOL)doConnect:(NSString *)name password:(NSString *)password;

//断开连接
- (void)disConnect;

- (void)disConnectAfterSending;

//发送消息
- (void)sendMessage:(NSString *)message toName:(NSString *)toName fromName:(NSString *)fromName;

- (void)sendComposing:(NSString *)to_userName fromName:(NSString *)from_userName;

- (void)sendPause:(NSString *)to_userName fromName:(NSString *)from_userName;

- (void)sendGroupMessage:(NSString *)message toChatRoom:(NSString *)roomName fromUserName:(NSString *)userName fromDevice:(NSString *)device;
@end
