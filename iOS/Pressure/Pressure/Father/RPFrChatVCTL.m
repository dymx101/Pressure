//
//  RPFrChatVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPFrChatVCTL.h"
#import "RPXmppManager.h"
#import "RPProfile.h"
#import "MMProgressHUD.h"
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
@interface RPFrChatVCTL ()

@end

@implementation RPFrChatVCTL

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    
    [[RPXmppManager sharedInstance] doConnect:[authModel.profile.xmppProfile jID] xmppPassWord:[authModel.profile.xmppProfile password]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginSuccNotif:) name:kNotif_XmppLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginFailedNotif:) name:kNotif_XmppLoginFailed object:nil];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
            RPProfile *chatUser = [[RPProfile alloc] initWithJSONDic:serverResp.obj[kMetaKey_Profile]];
            [[RPXmppManager sharedInstance] sendMessage:@"sb" toUser:chatUser.xmppProfile];
        }
    }
}

#pragma mark -
#pragma mark Xmpp Notification
- (void)handleXmppLoginSuccNotif:(NSNotification *)notif
{
    [MMProgressHUD dismissWithSuccess:@"登录成功"];
    [[RPXmppManager sharedInstance] sendOnlineStatus:User_Xmpp_OnlineStatus_Online];
    [self serverCallFrMatch];
}

- (void)handleXmppLoginFailedNotif:(NSNotification *)notif
{
    [MMProgressHUD dismissWithSuccess:@"登录失败"];
    
}




@end
