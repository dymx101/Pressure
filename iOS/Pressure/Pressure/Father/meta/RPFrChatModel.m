//
//  RPFrChatModel.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatModel.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
#import "RPMessage.h"
#import "RPChat.h"
#import "RPAppServerOperation.h"
static RPFrChatModel *frChatModel = nil;
@implementation RPFrChatModel


+ (RPFrChatModel *)sharedInstance {
    
    if (!frChatModel)
    {
        frChatModel = [[RPFrChatModel alloc] init];
        frChatModel.fatherChats = [[NSMutableArray alloc] init];
        frChatModel.talkerChats = [[NSMutableArray alloc] init];
    }
    return frChatModel;
}


/**
 *  返回当前正在聊天的用户
 *
 *  @return
 */
+ (RPChat *)nowChat
{
    RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
    switch (chatModel.type) {
        case RPFrChatModel_ChatingType_Father:
        {
            if ([chatModel.talkerChats count] >= chatModel.talkerChatingIndex)
            {
                return nil;
            }
            return [chatModel.talkerChats objectAtIndex:chatModel.talkerChatingIndex];
        }
            break;
        case RPFrChatModel_ChatingType_Talker:
        {
            if ([chatModel.fatherChats count] >= chatModel.fatherChatingIndex)
            {
                return nil;
            }
            return [chatModel.fatherChats objectAtIndex:chatModel.fatherChatingIndex];
        }
            break;
        default:
            break;
    }
    return nil;
}

- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic
{
    //保存到数据库里面
    RPMessage *rpMessage = [[RPMessage alloc] initWithJSONDic:messageDic];
    [rpMessage saveToDB];
    return YES;
}

@end
