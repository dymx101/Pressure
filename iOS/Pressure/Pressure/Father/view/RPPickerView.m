//
//  RPPickerView.m
//  Pressure
//
//  Created by eason on 11/17/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPPickerView.h"
#define RPPickerViewHeight 216
@interface RPPickerView ()
{
    UIToolbar    *_pickerToolBar;
    CGFloat      _showingOriginY;
}
@end

@implementation RPPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame target:(id)target originY:(CGFloat)originY
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _showingOriginY = originY;
        
        if (!_pickerToolBar)
        {
            _pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
            [self addSubview:_pickerToolBar];
        }
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnClick)];
        leftItem.title = @"取消";
        [items addObject:leftItem];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:space];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(okBtnClick)];
        rightItem.title = @"完成";
        [items addObject:rightItem];
        
        [_pickerToolBar setItems:items];
        
        if (!_picker)
        {
            
            _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pickerToolBar.frame), CGRectGetWidth(self.frame), RPPickerViewHeight)];
            _picker.delegate = target;
            [self addSubview:_picker];
        }
    }
    return self;
}



- (void)cancelBtnClick
{
    [self hide:YES];
    if ([self.delegate respondsToSelector:@selector(rpPickerViewCanceled)])
    {
        [self.delegate rpPickerViewCanceled];
    }
}

- (void)okBtnClick
{
    [self hide:YES];
    if ([self.delegate respondsToSelector:@selector(rpPickerViewFinished:)])
    {
        
        [self.delegate rpPickerViewFinished:@""];
    }
}

- (void)show:(BOOL)animated timeStr:(NSString *)timeStr
{
    
    [self show:animated];
}

- (void)show:(BOOL)animated
{
    if (self.frame.origin.y == _showingOriginY)
    {
        return;
    }
    CGRect frame    = self.frame;
    frame.origin.y  = _showingOriginY;
    if (animated)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame     = frame;
        }];
    }else{
        self.frame     = frame;
    }
    
}

- (void)hide:(BOOL)animated
{
    if (self.frame.origin.y == _showingOriginY - self.frame.size.height)
    {
        return;
    }
    CGRect frame    = self.frame;
    frame.origin.y  = _showingOriginY + self.frame.size.height;
    if (animated)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame     = frame;
        }];
    }else{
        self.frame     = frame;
    }
}
@end
