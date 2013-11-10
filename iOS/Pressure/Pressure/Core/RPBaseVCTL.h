//
//  RPBaseVCTL.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPBaseVCTL : UIViewController


@property (nonatomic,retain) UIView *maskView;

- (void)backToPrefix;
- (void)maskViewTapGesture:(UITapGestureRecognizer *)gesture;

@end
