//
//  RPFrChatModel.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatModel.h"
#import "RPProfile.h"
#import "RPMessage.h"
static RPFrChatModel *frChatModel = nil;
@implementation RPFrChatModel


+ (RPFrChatModel *)sharedInstance {
    
    if (!frChatModel)
    {
        frChatModel = [[RPFrChatModel alloc] init];
        frChatModel.fatherUsers = [[NSMutableArray alloc] init];
        frChatModel.talkerUsers = [[NSMutableArray alloc] init];
    }
    return frChatModel;
}


- (void)resetChatingUserState:(RPProfile *)chatingUser
{
    NSMutableArray *users = nil;
    switch (_type) {
        case RPFrChatModel_ChatingType_Father:
        {
            users = _talkerUsers;
        }
            break;
        case RPFrChatModel_ChatingType_Talker:
        {
            users = _fatherUsers;
            
        }
            break;
        default:
            break;
    }
    for (RPProfile *chatUser  in users)
    {
        if (chatUser.userId != chatingUser.userId)
        {
            chatUser.isChating = NO;
        }
        
    }
}

/**
 *  返回当前正在聊天的用户
 *
 *  @return
 */
- (RPProfile *)chatingUser
{
    switch (_type) {
        case RPFrChatModel_ChatingType_Father:
        {
            for (RPProfile *chatUser  in _talkerUsers)
            {
                if (chatUser.isChating)
                {
                    return chatUser;
                }
            }
        }
            break;
        case RPFrChatModel_ChatingType_Talker:
        {
            for (RPProfile *chatUser  in _fatherUsers)
            {
                if (chatUser.isChating)
                {
                    return chatUser;
                }
            }
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
