//
//  RPFrChatModel.h
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
typedef enum _RPFrChatModel_ChatingType
{
    RPFrChatModel_ChatingType_Talker,
    RPFrChatModel_ChatingType_Father
}RPFrChatModel_ChatingType;
@class RPProfile;
@class RPChat;
@interface RPFrChatModel : RPObject


@property (nonatomic) RPFrChatModel_ChatingType type;
//当前用户的倾诉用户
@property (nonatomic,retain) NSMutableArray *talkerChats;
//当前用户的神父用户
@property (nonatomic,retain) NSMutableArray *fatherChats;


@property (nonatomic) int talkerChatingIndex;
@property (nonatomic) int fatherChatingIndex;

+ (RPFrChatModel *)sharedInstance ;

/**
 *  当前正在聊天的用户
 *
 *  @return
 */
+ (RPChat *)nowChat;

- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic;

@end
