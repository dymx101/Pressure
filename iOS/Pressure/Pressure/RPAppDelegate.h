//
//  RPAppDelegate.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLNavigationController;
@interface RPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain) MLNavigationController *nav;


- (void)enableXmppTimer;
@end
