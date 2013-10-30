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
#import "RPAuthModel.h"
#import "RPSinaModel.h"
@interface RPAppDelegate ()  <WeiboSDKDelegate>
{
    
}
@end

@implementation RPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK registerApp:@"246524502"];
    [WeiboSDK enableDebugMode:YES];
    
    
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    self.window           = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    [self choiceViewController];
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
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


- (void)choiceViewController
{
    
    if ([[RPAuthModel sharedInstance] logined])
    {
        
    }else
    {
        RPLoginVCTL *loginVCTL = [[RPLoginVCTL alloc] init];
        if (!_nav)
        {
            _nav = [[MLNavigationController alloc] initWithRootViewController:loginVCTL];
        }
        self.window.rootViewController = _nav;
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
        RPSinaModel *sinaModel  = [[RPSinaModel alloc] initWithJSONDic:response.userInfo];
        RPAuthModel *authModel  = [RPAuthModel sharedInstance];
        authModel.sinaModel     = sinaModel;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_SinaWeiBoAuthSucc object:nil];
    }
    
}

@end
