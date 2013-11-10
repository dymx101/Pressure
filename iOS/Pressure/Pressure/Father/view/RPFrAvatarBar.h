//
//  RPFrAvatarBar.h
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RPFrAvatarBar_Width  100
#define RPFrAvatarBar_Height 45
@class RPProfile;
@interface RPFrAvatarBar : UIView

/**
 *  设置头像
 *
 *  @param profile 
 */
- (void)resetAvatarBar:(RPProfile *)profile;
@end
