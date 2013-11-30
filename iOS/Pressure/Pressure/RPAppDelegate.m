//
//  RPAppDelegate.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAppDelegate.h"
#import "RPIndexVCTL.h"
#import "MLNavigationController.h"
#import "WeiboSDK.h"
#import "RPLoginVCTL.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
#import "RPThirdModel.h"
#import "RPXmppManager.h"
#import "RPAppServerOperation.h"
#import "FMDBObject.h"
#import "RPXmppProfile.h"
#import "RPXmppStream.h"
#define kOnlineTimerInterval  3
@interface RPAppDelegate ()  <WeiboSDKDelegate>
{
    NSTimer *_xmppConnectTimer;
}
@end

@implementation RPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK registerApp:kSinaRegisterKey];
    [WeiboSDK enableDebugMode:YES];
    
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    self.window           = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    [self choiceViewController];
    [self performSelector:@selector(doSomethingWhenOpenApp)];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [_xmppConnectTimer fire];
    [_xmppConnectTimer invalidate];
    [[RPXmppStream sharedInstance] sendofflineStatus];
    [[RPXmppStream sharedInstance] disConnectAfterSending];
    [RPAuthModel sharedInstance].userXmppOnline = NO;
    [[RPAuthModel sharedInstance] saveData];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    [[RPXmppManager sharedInstance] doConnect:[authModel.profile.xmppProfile jID] xmppPassWord:[authModel.profile.xmppProfile password]];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)enableXmppTimer {
    
    @synchronized (self) {
        
        if ([_xmppConnectTimer isValid] && _xmppConnectTimer) {
            return;
        }
        
        [_xmppConnectTimer fire];
        _xmppConnectTimer = [NSTimer scheduledTimerWithTimeInterval:kOnlineTimerInterval target:self selector:@selector(onlineTimer) userInfo:nil repeats:YES];
    }
}

- (void)onlineTimer {
    
    if (!_xmppConnectTimer) {
        return;
    }
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (![[RPAuthModel sharedInstance] userXmppOnline]) {
        MLOG(@"user xmpp not connected,begin to connect");
        [[RPXmppStream sharedInstance] doConnect:[authModel.profile.xmppProfile jID] password:[authModel.profile.xmppProfile password]];
        return;
    }
    
    MLOG(@"online timer is pinging");
    [[RPXmppStream sharedInstance] sendPingFromUser:[authModel.profile.xmppProfile jID]];
}

- (void)doSomethingWhenOpenApp
{

}

- (void)choiceViewController
{
    if ([[RPAuthModel sharedInstance] logined] && [RPAuthModel sharedInstance].profile.gender >= 0)
    {
        if (!_nav)
        {
            RPIndexVCTL *indexVCTL = [[RPIndexVCTL alloc] init];
            _nav = [[MLNavigationController alloc] initWithRootViewController:indexVCTL];
            _nav.hidesBottomBarWhenPushed = YES;
        }
        if (self.window.rootViewController != _nav)
        {
            self.window.rootViewController = _nav;
        }
    }else
    {
        RPLoginVCTL *loginVCTL = [[RPLoginVCTL alloc] init];
        self.window.rootViewController = loginVCTL;
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choiceViewController) name:kNotif_LoginSucc object:nil];
    }
    
}

#pragma mark -
#pragma mark WBBaseRequest Delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"%@",@"123");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    //如果是认证回调
    if ([response isKindOfClass:[WBAuthorizeResponse class]])
    {
        RPThirdModel *sinaModel  = [[RPThirdModel alloc] initWithJSONDic:response.userInfo];
        sinaModel.type = RPThirdModelType_SinaWeiBo;
        RPAuthModel *authModel  = [RPAuthModel sharedInstance];
        authModel.thirdModel     = sinaModel ;
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_SinaWeiBoAuthSucc object:nil];
        [[RPAppServerOperation sharedRPAppServerOperation] asynLoginWithThirdPartAuth];
    }
    
}


+ (void)initialize
{
    
    //第一次登陆的一些操作，包括数据库新建，更新等
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault boolForKey:kUserDefault_EverLaunched])
    {
        [userDefault setBool:YES forKey:kUserDefault_EverLaunched];
        [FMDBObject sharedInstance];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //打开就清0
}


@end
