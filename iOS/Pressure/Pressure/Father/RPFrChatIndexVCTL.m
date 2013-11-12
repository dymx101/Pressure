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
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
#import "RPFrChatVCTL.h"
#import "RPAppModel.h"
@interface RPFrChatIndexVCTL ()
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
    
    UIButton *matchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [matchBtn addTarget:self action:@selector(matchClick:) forControlEvents:UIControlEventTouchUpInside];
    matchBtn.frame = CGRectMake(50, 50, 100, 44);
    matchBtn.center = self.view.center;
    [matchBtn setTitle:@"找神父" forState:UIControlStateNormal];
    [self.view addSubview:matchBtn];
    

    
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

- (void)matchClick:(id)sender
{
    [self serverCallFrMatch];
}

#pragma mark -
#pragma mark Server
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
            [[RPAppModel sharedInstance].chatUserArray addObject:_chatUser];
            [[RPAppModel sharedInstance] resetChatingUserState:_chatUser];
            RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] init];
            [self.navigationController pushViewController:chatVCTL animated:YES];
        }
    }
}





@end
