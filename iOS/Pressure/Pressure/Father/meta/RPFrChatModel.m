//
//  RPFrChatModel.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatModel.h"
#import "RPProfile.h"
#import "RPXmppProfile.h"
#import "FMDBObject.h"
#import "RPAuthModel.h"
#import "RPMessage.h"
#import "RPChat.h"
#import "JSON20.h"
#import "RPAppServerOperation.h"
#define kTableName @"tb_chat"
static RPFrChatModel *frChatModel = nil;
@interface RPFrChatModel ()
{
    
}
@end
@implementation RPFrChatModel


+ (RPFrChatModel *)sharedInstance {
    
    if (!frChatModel)
    {
        frChatModel = [[RPFrChatModel alloc] init];
        frChatModel.fatherChats = [[NSMutableArray alloc] init];
        frChatModel.talkerChats = [[NSMutableArray alloc] init];
        frChatModel.fatherDic = [[NSMutableDictionary alloc] init];
        frChatModel.talkerDic = [[NSMutableDictionary alloc] init];
    }
    return frChatModel;
}

- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic
{
    //保存到数据库里面
    RPMessage *rpMessage = [[RPMessage alloc] initWithJSONDic:messageDic];
    [rpMessage saveToDB];
    return YES;
}

- (BOOL)checkUserFromMessage:(NSDictionary *)messageDic jid:(NSString *)jid
{
    RPMessage *rpMessage = [[RPMessage alloc] initWithJSONDic:messageDic];
    RPChat *chat = [self chatInFatherChat:rpMessage.userId];
    if (chat)
    {
        [self bringFatherChatToFront:chat];
        return YES;
    }
    chat = [self chatInTalkerChat:rpMessage.userId];
    if (chat)
    {
        [self bringTalkerChatToFront:chat];
        return YES;
    }
    [[RPAppServerOperation sharedRPAppServerOperation] serverCallGetUserProfileByJid:jid type:RPChat_VisitUserType_None];
    return NO;
}


- (void)bringFatherChatToFront:(RPChat *)chat
{
    @synchronized(_fatherChats)
    {
        NSMutableArray *chatArray = [[NSMutableArray alloc] init];
        [chatArray addObject:chat];
        for(RPChat *achat in _fatherChats)
        {
            if (achat.chat_id != chat.chat_id)
            {
                [chatArray addObject:achat];
            }
        }
        _fatherChats = chatArray;
    }
}

- (void)bringTalkerChatToFront:(RPChat *)chat
{
    @synchronized(_talkerChats)
    {
        NSMutableArray *chatArray = [[NSMutableArray alloc] init];
        [chatArray addObject:chat];
        for(RPChat *achat in _talkerChats)
        {
            if (achat.chat_id != chat.chat_id)
            {
                [chatArray addObject:achat];
            }
        }
        _talkerChats = chatArray;
    }
}


- (void)addTalkerChatAtIndex:(RPChat *)chat index:(int)index
{
    @synchronized(_talkerChats)
    {
        if (index < 0)
        {
            [_talkerChats addObject:chat];
        }else
        {
            [_talkerChats insertObject:chat atIndex:index];
        }
        
    }
}

- (void)addFatherChatAtIndex:(RPChat *)chat index:(int)index
{
    @synchronized(_fatherChats)
    {
        if (index < 0)
        {
            [_fatherChats addObject:chat];
        }else
        {
            [_fatherChats insertObject:chat atIndex:index];
        }

    }
}

- (void)addFatherChatsFromArray:(NSArray *)chats
{
    for(RPChat *chat in chats)
    {
        [self addFatherChatAtIndex:chat index:-1];
    }
}

- (void)addTalkerChatsFromArray:(NSArray *)chats
{
    for(RPChat *chat in chats)
    {
        [self addTalkerChatAtIndex:chat index:-1];
    }
}

- (void)removeAllFatherChats
{
    @synchronized(_fatherChats)
    {
        [_fatherChats removeAllObjects];
    }
}

- (void)removeAllTalkerChats
{
    @synchronized(_talkerChats)
    {
        [_talkerChats removeAllObjects];
    }
}

- (void)resetTalkerChat:(NSArray *)chats
{
    @synchronized(_talkerChats)
    {
        [_talkerChats removeAllObjects];
        [_talkerChats addObjectsFromArray:chats];
    }
}

- (void)resetFatherChat:(NSArray *)chats
{
    @synchronized(_fatherChats)
    {
        [_fatherChats removeAllObjects];
        [_fatherChats addObjectsFromArray:chats];
    }
}

- (RPChat *)fatherChatAtIndex:(int)index
{
    @synchronized(_fatherChats)
    {
        if ([_fatherChats count] > index)
        {
            return [_fatherChats objectAtIndex:index];
        }
        return nil;
    }
}

- (RPChat *)talkerChatAtIndex:(int)index
{
    @synchronized(_talkerChats)
    {
        if ([_talkerChats count] > index)
        {
            return [_talkerChats objectAtIndex:index];
        }
        return nil;
    }
}

- (RPChat *)chatInFatherChat:(long long)userId
{
    for (RPChat *aChat in _fatherChats)
    {
        if (aChat.profile.userId == userId)
        {
            return aChat;
        }
    }
    return NO;
}

- (RPChat *)chatInTalkerChat:(long long)userId
{
    for (RPChat *aChat in _talkerChats)
    {
        if (aChat.profile.userId == userId)
        {
            return aChat;
        }
    }
    return NO;
}
@end
