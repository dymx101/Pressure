//
//  RPAppModel.m
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPAppModel.h"
#import "RPMessage.h"
#import "JSON20.h"
#import "RPProfile.h"
static RPAppModel *appModel = nil;
@implementation RPAppModel


+ (RPAppModel *)sharedInstance {
    
    if (!appModel)
    {
        appModel = [[RPAppModel alloc] init];
    }
    return appModel;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        _chatUserArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic
{
    //保存到数据库里面
    RPMessage *rpMessage = [[RPMessage alloc] initWithJSONDic:messageDic];
    [rpMessage saveToDB];
    return YES;
}

- (void)resetChatingUserState:(RPProfile *)chatingUser
{
    for (RPProfile *chatUser  in _chatUserArray)
    {
        if (chatUser.userId == chatingUser.userId)
        {
            chatUser.isChating = YES;
        }else
        {
            chatUser.isChating = NO;
        }
    }
}

- (RPProfile *)chatingUser
{
    for (RPProfile *chatUser  in _chatUserArray)
    {
        if (chatUser.isChating)
        {
            return chatUser;
        }
    }
    return nil;
}
@end
