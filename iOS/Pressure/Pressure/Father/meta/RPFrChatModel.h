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
@interface RPFrChatModel : RPObject


@property (nonatomic) RPFrChatModel_ChatingType type;
//当前用户的倾诉用户
@property (nonatomic,retain) NSMutableArray *talkerUsers;
//当前用户的神父用户
@property (nonatomic,retain) NSMutableArray *fatherUsers;



+ (RPFrChatModel *)sharedInstance ;

- (void)resetChatingUserState:(RPProfile *)chatingUser;
/**
 *  当前正在聊天的用户
 *
 *  @return
 */
- (RPProfile *)chatingUser;

- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic;;
@end
