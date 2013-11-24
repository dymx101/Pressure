//
//  RPBaseVCTL.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPBaseBar;
@interface RPBaseVCTL : UIViewController


@property (nonatomic,retain) UIView *maskView;
@property (nonatomic) BOOL hideHeaderBar;
@property (nonatomic,retain) RPBaseBar *bar;
@property (nonatomic,retain) UIView *contentView;


- (void)backToPrefix;
- (void)maskViewTapGesture:(UITapGestureRecognizer *)gesture;
- (void)leftButtonClick;
- (void)rightButtonClick;

@end
