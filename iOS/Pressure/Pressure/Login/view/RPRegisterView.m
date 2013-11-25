//
//  RPRegisterView.m
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPRegisterView.h"
#import "GradientButton.h"
@interface RPRegisterView ()
{
    UITextField *_userNameField;
    UITextField *_passWordField;
    UITextField *_rePassField;
}
@end
@implementation RPRegisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 240, 30)];
        [_userNameField setPlaceholder:@"用户名"];
        _userNameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _userNameField.bounds.size.height)];
        _userNameField.leftViewMode = UITextFieldViewModeAlways;
        _userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameField.returnKeyType = UIReturnKeyNext;
        [self addSubview:_userNameField];
        
        
        _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(_userNameField.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        _passWordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _userNameField.bounds.size.height)];
        _passWordField.leftViewMode = UITextFieldViewModeAlways;
        [_passWordField setPlaceholder:@"新密码"];
        _passWordField.secureTextEntry = YES;
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passWordField.keyboardType  = UIKeyboardTypeASCIICapable;
        _passWordField.returnKeyType = UIReturnKeyNext;
        [self addSubview:_passWordField];
        
        _rePassField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(_passWordField.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        _rePassField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _userNameField.bounds.size.height)];
        _rePassField.leftViewMode = UITextFieldViewModeAlways;
        [_rePassField setPlaceholder:@"重新输入密码"];
        _rePassField.secureTextEntry = YES;
        _rePassField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rePassField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _rePassField.returnKeyType = UIReturnKeyDone;
        _rePassField.keyboardType  = UIKeyboardTypeASCIICapable;
        [self addSubview:_rePassField];
        
        
        GradientButton *registerBtn = [[GradientButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(_rePassField.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitle:@"注册" forState:UIControlStateHighlighted];
        [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.normalGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        registerBtn.normalGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        registerBtn.highlightGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        registerBtn.highlightGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        [self addSubview:registerBtn];
        
        
        GradientButton *cancelBtn = [[GradientButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(registerBtn.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.normalGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        cancelBtn.normalGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        cancelBtn.highlightGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        cancelBtn.highlightGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        [self addSubview:cancelBtn];
    }
    return self;
}


- (void)registerBtnClick:(id)sender
{
    if ([_passWordField.text isEqualToString:_rePassField.text])
    {
#warning 请输入正确密码
        return;
    }
    if ([self.delegate respondsToSelector:@selector(rpRegisterViewRegister:pass:)])
    {
        [self.delegate rpRegisterViewRegister:_userNameField.text pass:_passWordField.text];
    }
}

- (void)cancelBtnClick:(id)sender
{
    if (_cancelBlock)
    {
        _cancelBlock();
    }
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
    [_rePassField resignFirstResponder];
}

@end
