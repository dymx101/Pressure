//
//  RPInputView.h
//  Pressure
//
//  Created by eason on 11/8/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRPInputView_Up_Height 45
@class RPTextField;
@protocol RPInputViewDelegate <NSObject>

- (void)rpInputViewWillShow;
- (void)rpInputViewWillHide;
- (void)rpInputViewTextEnd:(NSString *)text;
- (void)rpInputViewWillChangeHeight;

@end

@interface RPInputView : UIView

@property (nonatomic) BOOL showing;
@property (nonatomic,assign) id<RPInputViewDelegate> delegate;


- (void)rpInputViewShow;
- (void)rpInputViewHide;
@end
