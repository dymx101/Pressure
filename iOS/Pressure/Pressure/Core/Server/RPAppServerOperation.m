//
//  RPAppServerOperation.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAppServerOperation.h"
#import "SynthesizeSingleton.h"
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
#import "RPThirdModel.h"
#import "RPProfile.h"
#import "RPXmppProfile.h"
#import "RPFrChatModel.h"
#import "RPChatType.h"
#import "RPChat.h"
#import "RPForum.h"
#import "RPChat.h"
#import "BlockAlertView.h"
#import "RPUtilities.h"
@implementation RPAppServerOperation


SYNTHESIZE_SINGLETON_FOR_CLASS(RPAppServerOperation)

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (void)serverCallRefreshToken
{
    
}

- (void)asynServerCallToBeFather
{
    
}

- (void)asynServerCallChatType
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    RPServerRequest *serverReq =  [[RPServerOperation sharedInstance] generateDefaultServerRequest:self operationType:kServerApi_GetChatTypeList dic:mulDic];
    [[RPServerOperation sharedInstance] asyncToServerByRequest:serverReq];
}


- (void)asynLoginWithThirdPartAuth
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    RPThirdModel *thirdModel = authModel.thirdModel;
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(thirdModel.accessToken), kRPServerRequest_Access_Token);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2STR(thirdModel.expires_in), kRPServerRequest_Expire_In);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(thirdModel.uid), kRPServerRequest_Uid);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(thirdModel.type), kRPServerRequest_Type);
    
    RPServerRequest *serverReq =  [[RPServerOperation sharedInstance] generateDefaultServerRequest:self operationType:kServerApi_ThirdPartLogin dic:mulDic];
    [[RPServerOperation sharedInstance] asyncToServerByRequest:serverReq];
}

- (void)serverCallGetUserProfileByJid:(NSString *)xmppUsername type:(RPChat_UserType)type
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(xmppUsername), kRPServerRequest_XmppUserName);
    if (type > 0)
    {
        SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(type), kRPServerRequest_Type);
    }
    RPServerRequest *serverReq =  [[RPServerOperation sharedInstance] generateDefaultServerRequest:self operationType:kServerApi_GetUserProfileByJid dic:mulDic];
    [[RPServerOperation sharedInstance] syncToServerByRequest:serverReq];
}

- (void)syncServerCallChatingUser
{
    
}

#pragma mark -
#pragma mark ServerResponse Delegate
- (void)serverRequestDidSyncCallback:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_ThirdPartLogin])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPAuthModel *authModel = [RPAuthModel sharedInstance];
            [authModel setLoginSuccValue:serverResp.obj];
            [authModel saveData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_ThirdPartLoginSucc object:nil];
        }
    }
    
    if ([serverResp.operationType isEqualToString:kServerApi_GetChatTypeList])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            NSMutableArray *chatTypes = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in serverResp.obj[kMetaKey_ChatTypeList])
            {
                RPChatType *chatType = [[RPChatType alloc] initWithJSONDic:dic];
                [chatTypes addObject:chatType];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_GetChatTypesSucc object:nil userInfo:[NSDictionary dictionaryWithObject:chatTypes forKey:kNotif_GetChatTypesSucc_UserInfo]];
        }
    }
    
    if ([serverResp.operationType isEqualToString:kServerApi_GetUserProfileByJid])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPChat *returnChat = [[RPChat alloc] initWithJSONDic:serverResp.obj[kMetaKey_Chat]];
            RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
            if (returnChat.userType == RPChat_UserType_Talker)
            {
                BOOL findChatInList = NO;
                for (RPChat *chat in chatModel.talkerChats)
                {
                    if (chat.profile.userId == returnChat.profile.userId)
                    {
                        findChatInList = YES;
                        break;
                    }
                }
                if (!findChatInList)
                {
                    [chatModel.talkerChats addObject:returnChat];
                }
            }else if (returnChat.userType == RPChat_UserType_Father)
            {
                BOOL findChatInList = NO;
                for (RPChat *chat in chatModel.talkerChats)
                {
                    if (chat.profile.userId == returnChat.profile.userId)
                    {
                        findChatInList = YES;
                        break;
                    }
                }
                if (!findChatInList)
                {
                    [chatModel.talkerChats addObject:returnChat];
                }
            }
        }else if (serverResp.code == RPServerResponseCode_NoChatingGroup)
        {
            //不在聊天组中
        }
    }
  
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
@end
