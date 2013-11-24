//
//  RPFrChatVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPFrChatIndexVCTL.h"
#import "RPXmppManager.h"
#import "RPProfile.h"
#import "MMProgressHUD.h"
#import "RPFrChatModel.h"
#import "RPSearchType.h"
#import "RPChat.h"
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
#import "RPBaseVCTL+Server.h"
#import "RPChatType.h"
#import "RPFrChatVCTL.h"
#import "RPAppModel.h"
#import "RPFrFilterDialog.h"
@interface RPFrChatIndexVCTL () <CustomDialogDelegate>
{

}

@end

@implementation RPFrChatIndexVCTL

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIButton *asTalkerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [asTalkerBtn addTarget:self action:@selector(asTalkerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    asTalkerBtn.frame = CGRectMake(50, 50, 100, 44);
    [asTalkerBtn setTitle:@"找神父" forState:UIControlStateNormal];
    [self.contentView addSubview:asTalkerBtn];
    
    UIButton *asFatherBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [asFatherBtn addTarget:self action:@selector(asFatherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    asFatherBtn.frame = CGRectMake(100, 100, 100, 44);
    [asFatherBtn setTitle:@"做神父" forState:UIControlStateNormal];
    [self.contentView addSubview:asFatherBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)asTalkerBtnClick:(id)sender
{
    RPFrFilterDialog *dialog = [[RPFrFilterDialog alloc] initWithDelegate:self type:RPFrFilterDialog_Type_Find_Father];
    [dialog show];
}

- (void)asFatherBtnClick:(id)sender
{
    [self serverCallAsFather];
}

#pragma mark -
#pragma mark Server
- (void)serverCallAsFather
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    RPProfile *profile = authModel.profile;
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, @"17~24", kRPServerRequest_AgeRange);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(profile.gender), kRPServerRequest_Gender);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(1), kRPServerRequest_ChatType);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(0), kRPServerRequest_Type);
    [self serverCall:kServerApi_UpdateMatchType data:mulDic];
}

- (void)serverCallFrMatch:(RPSearchType *)searchType
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(searchType.ageRange), kRPServerRequest_AgeRange);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(searchType.gender), kRPServerRequest_Gender);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(searchType.chatType.dbId), kRPServerRequest_ChatType);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(searchType.city), kRPServerRequest_City);
    [self serverCall:kServerApi_FrMatch data:mulDic];
}

- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_FrMatch])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPChat *chat = [[RPChat alloc] initWithJSONDic:serverResp.obj[kMetaKey_Chat]];
            chat.userType = RPChat_UserType_Father;
            
            RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
            chatModel.type  = RPFrChatModel_ChatingType_Talker;
            [chatModel.fatherChats insertObject:chat atIndex:0];
            chatModel.fatherChatingIndex = 0;
            
            RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] init];
            [self.navigationController pushViewController:chatVCTL animated:YES];
        }
    }
    if ([serverResp.operationType isEqualToString:kServerApi_UpdateMatchType])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            
        }
    }
}

#pragma mark -
#pragma mark CustomDialog Delegate
- (void)dialogDidComplete:(CustomDialog *)dialog
{
    RPSearchType *searchType = ((RPFrFilterDialog *)dialog).searchType;
    [self serverCallFrMatch:searchType];
}

- (void)dialogDidNotComplete:(CustomDialog *)dialog
{
    
}


@end
