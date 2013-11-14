//
//  RPUserProfileHeaderView.h
//  Pressure
//
//  Created by eason on 11/12/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RPUserProfileHeaderView_Origin_Height 200
#define RPUserProfileHeaderView_Max_Height    300
@class RPProfile;
@interface RPUserProfileHeaderView : UIView

- (id)initWithFrame:(CGRect)frame profile:(RPProfile *)profile;
@end
