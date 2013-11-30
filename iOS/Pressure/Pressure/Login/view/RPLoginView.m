//
//  RPLoginView.m
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPLoginView.h"
#import "WeiboSDK.h"
#import "GradientButton.h"
@interface RPLoginView () <UITextFieldDelegate>
{
    UITextField *_userNameField;
    UITextField *_passWordField;
}
@end
@implementation RPLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiboBtn setImage:[UIImage imageNamed:@"icon_weibo.png"] forState:UIControlStateNormal];
        [weiboBtn setImage:[UIImage imageNamed:@"icon_weibo.png"] forState:UIControlStateHighlighted];
        weiboBtn.frame = CGRectMake((SCREEN_WIDTH - 70)/2, 80, 70, 70);
        [weiboBtn addTarget:self action:@selector(weiboBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weiboBtn];
        
        
        UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(weiboBtn.frame), CGRectGetMaxY(weiboBtn.frame), 70, 20)];
        weiboLabel.text = @"新浪微博";
        weiboLabel.textAlignment = NSTextAlignmentCenter;
        weiboLabel.font = [UIFont systemFontOfSize:12];
        weiboLabel.backgroundColor = [UIColor clearColor];
        weiboLabel.textColor = Default_Deep_Black;
        [self addSubview:weiboLabel];
        
        
        _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(weiboLabel.frame) + 20, 240, 30)];
        _userNameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _userNameField.bounds.size.height)];
        _userNameField.leftViewMode = UITextFieldViewModeAlways;
        _userNameField.delegate = self;
        [_userNameField setPlaceholder:@"邮箱\\手机号"];
        _userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameField.returnKeyType = UIReturnKeyNext;
        _userNameField.layer.borderColor = [Default_Low_Gray CGColor];
        _userNameField.layer.borderWidth = 1.0;
        [self addSubview:_userNameField];
        
        _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(_userNameField.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        _passWordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _passWordField.bounds.size.height)];
        _passWordField.leftViewMode = UITextFieldViewModeAlways;
        [_passWordField setDelegate:self];
        [_passWordField setPlaceholder:@"密码"];
        _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passWordField.secureTextEntry = YES;
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordField.keyboardType  = UIKeyboardTypeASCIICapable;
        _passWordField.returnKeyType = UIReturnKeyDone;
        _passWordField.layer.borderWidth = 1.0;
        _passWordField.layer.borderColor = [Default_Low_Gray CGColor];
        [self addSubview:_passWordField];
        
        GradientButton *loginBtn = [[GradientButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame), CGRectGetMaxY(_passWordField.frame) + 10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitle:@"登录" forState:UIControlStateHighlighted];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.normalGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        loginBtn.normalGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        loginBtn.highlightGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        loginBtn.highlightGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        loginBtn.layer.cornerRadius = 5.0;
        [self addSubview:loginBtn];
        
        GradientButton *registerBtn = [[GradientButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameField.frame),10, CGRectGetWidth(_userNameField.frame), CGRectGetHeight(_userNameField.frame))];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitle:@"注册" forState:UIControlStateHighlighted];
        [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.normalGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        registerBtn.normalGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        registerBtn.highlightGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        registerBtn.highlightGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        [self addSubview:registerBtn];
    }
    return self;
}

- (void)registerBtnClick:(id)sender
{
    if (_registerBlock)
    {
        _registerBlock();
    }
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
}

- (void)loginBtnClick:(id)sender
{
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(rpLoginViewLogin:passWord:)])
    {
        [self.delegate rpLoginViewLogin:_userNameField.text passWord:_passWordField.text];
    }
}

- (void)weiboBtnClick:(id)sender
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://21beizi.com";
    request.scope = @"email,direct_messages_write";
    [WeiboSDK sendRequest:request];
}

@end
