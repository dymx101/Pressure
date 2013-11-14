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
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
#import "RPFrChatVCTL.h"
#import "RPAppModel.h"
#import "RPFrFilterDialog.h"
@interface RPFrChatIndexVCTL () <CustomDialogDelegate>
{
    RPProfile *_chatUser;
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
    if (_chatUser)
    {
        [[RPXmppManager sharedInstance] sendMessage:@"sb" toUser:_chatUser.xmppProfile];
    }
}

- (void)asTalkerBtnClick:(id)sender
{
    RPFrFilterDialog *dialog = [[RPFrFilterDialog alloc] initWithDelegate:self];
    [dialog show];
}

- (void)asFatherBtnClick:(id)sender
{
    
}

#pragma mark -
#pragma mark Server
- (void)serverCallAsFather
{
    
}

- (void)serverCallFrMatch
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    RPServerRequest *serverReq =  [[RPServerOperation sharedInstance] generateDefaultServerRequest:self operationType:kServerApi_FrMatch dic:mulDic];
    [[RPServerOperation sharedInstance] asyncToServerByRequest:serverReq];
}

- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_FrMatch])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            _chatUser = [[RPProfile alloc] initWithJSONDic:serverResp.obj[kMetaKey_Profile]];
            _chatUser.userType = RPProfile_UserType_Father;
            _chatUser.isChating = YES;
            RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
            chatModel.type  = RPFrChatModel_ChatingType_Talker;
            [chatModel.fatherUsers addObject:_chatUser];
            [chatModel resetChatingUserState:_chatUser];
            RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] init];
            [self.navigationController pushViewController:chatVCTL animated:YES];
        }
    }
}


#pragma mark -
#pragma mark CustomDialog Delegate
- (void)dialogDidComplete:(CustomDialog *)dialog
{
    [self serverCallFrMatch];
   
}

- (void)dialogDidNotComplete:(CustomDialog *)dialog
{
    
}




@end
