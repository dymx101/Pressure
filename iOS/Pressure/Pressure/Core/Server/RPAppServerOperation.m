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
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_ThirdPartLoginSucc object:nil];
        }
    }
  
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
@end
