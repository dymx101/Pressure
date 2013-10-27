//
//  RPFrChatVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPFrChatVCTL.h"
#import "RPXmppManager.h"
#import "MMProgressHUD.h"
#import "RPAuthModel.h"
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
    [[RPXmppManager sharedInstance] doConnect:@"zys" xmppPassWord:@"zys"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginSuccNotif:) name:kNotif_XmppLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginFailedNotif:) name:kNotif_XmppLoginFailed object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Xmpp Notification
- (void)handleXmppLoginSuccNotif:(NSNotification *)notif
{
    [MMProgressHUD dismissWithSuccess:@"登录成功"];
    
}

- (void)handleXmppLoginFailedNotif:(NSNotification *)notif
{
    [MMProgressHUD dismissWithSuccess:@"登录失败"];
    
}




@end
