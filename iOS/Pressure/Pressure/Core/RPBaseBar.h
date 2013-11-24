//
//  RPBaseBar.h
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RPBaseBar_Height 49
@class RPBaseBar;
@protocol RPBaseBarDelegate <NSObject>

- (void)leftButtonClick:(RPBaseBar *)bar;
- (void)rightButtonClick:(RPBaseBar *)bar;

@end

@interface RPBaseBar : UIView

@property (nonatomic,assign) id<RPBaseBarDelegate> delegate;

- (void)setTitle:(NSString *)title;
- (void)setRightBtnWithText:(NSString *)text;
@end
