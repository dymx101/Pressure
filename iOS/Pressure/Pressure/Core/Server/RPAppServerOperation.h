//
//  RPAppServerOperation.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPChat.h"

/**
 用于处理返回后的ui显示
 */
typedef enum AppServerOperationResponse_Type
{
    //什么都不用管
    AppServerOperationResponse_Type_None,
    //直接返回，不需要继续往下层做操作
    AppServerOperationResponse_Type_ChangeUser,
    //继续往下走，不过后续不需要做隐藏hud操作
    AppServerOperationResponse_Type_ShowError
}AppServerOperationResponse_Type;
@class RPForum;
@interface RPAppServerOperation : NSObject

@property (nonatomic) BOOL refreshingToken;


+ (RPAppServerOperation *)sharedRPAppServerOperation;


- (void)asynServerCallToBeFather;
- (void)serverCallRefreshToken;
- (void)asynServerCallChatType;
- (void)serverCallGetUserProfileByJid:(NSString *)xmppUsername type:(RPChat_UserType)type;
- (void)asynLoginWithThirdPartAuth;
/**
 *  同步聊天用户
 */
- (void)syncServerCallChatingUser;

@end
