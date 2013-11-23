//
//  RPPickerView.h
//  Pressure
//
//  Created by eason on 11/17/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RPPickerViewDelegate <NSObject>

- (void)rpPickerViewCanceled;
- (void)rpPickerViewFinished:(NSString *)value;
@optional
- (void)rpPickerViewValueChange:(NSString *)value;

@end
@interface RPPickerView : UIView


@property (nonatomic,retain) UIPickerView *picker;
@property (nonatomic,assign) id<RPPickerViewDelegate> delegate;


- (id)initWithFrame:(CGRect)frame target:(id)target originY:(CGFloat)originY;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;
@end
