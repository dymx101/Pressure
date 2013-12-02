//
//  RPFrChatModel.h
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
#import "RPChat.h"
//当前聊天的类型
@class RPProfile;
@interface RPFrChatModel : RPObject


@property (nonatomic) RPChat_VisitUserType type;
//当前用户的倾诉用户
@property (nonatomic,retain) NSMutableArray *talkerChats;
//当前用户的神父用户
@property (nonatomic,retain) NSMutableArray *fatherChats;

@property (nonatomic,retain) NSMutableDictionary *talkerDic;
@property (nonatomic,retain) NSMutableDictionary *fatherDic;

+ (RPFrChatModel *)sharedInstance ;


- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic;

/**
 *  检查用户是否在聊天中
 *
 *  @param fromUserName
 *
 *  @return 
 */
- (BOOL)checkUserFromMessage:(NSDictionary *)messageDic jid:(NSString *)jid;

- (void)addTalkerChatAtIndex:(RPChat *)chat index:(int)index;

- (void)addFatherChatAtIndex:(RPChat *)chat index:(int)index;

- (void)addFatherChatsFromArray:(NSArray *)chats;

- (void)addTalkerChatsFromArray:(NSArray *)chats;

- (void)removeAllFatherChats;

- (void)removeAllTalkerChats;
//
//- (void)resetTalkerChat:(NSArray *)chats;
//
//- (void)resetFatherChat:(NSArray *)chats;
//
//- (RPChat *)fatherChatAtIndex:(int)index;
//
//- (RPChat *)talkerChatAtIndex:(int)index;

- (RPChat *)chatInFatherChat:(long long)userId;

- (RPChat *)chatInTalkerChat:(long long)userId;
@end
