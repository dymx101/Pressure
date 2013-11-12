//
//  RPUserProfileVIew.h
//  Pressure
//
//  Created by eason on 11/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//  这个页面设置了就可以获得积分

#import <UIKit/UIKit.h>
@class RPProfile;
#define RPUserProfileView_Inside_Width 260
#define RPUserProfileView_Inside_Height 440

@protocol RPUserProfileViewDelegate <NSObject>


@end

@interface RPUserProfileView : UIView


@property (nonatomic,assign) id<RPUserProfileViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
