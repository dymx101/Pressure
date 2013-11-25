//
//  RPLoginView.m
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPLoginView.h"
#import "WeiboSDK.h"
@interface RPLoginView ()
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
        weiboBtn.frame = CGRectMake((SCREEN_WIDTH - 70)/2, 100, 70, 70);
        [weiboBtn addTarget:self action:@selector(weiboBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weiboBtn];
        
        
        UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(weiboBtn.frame), CGRectGetMaxY(weiboBtn.frame), 70, 20)];
        weiboLabel.text = @"新浪微博";
        weiboLabel.font = [UIFont systemFontOfSize:12];
        weiboLabel.backgroundColor = [UIColor clearColor];
        weiboLabel.textColor = Default_Deep_Black;
        [self addSubview:weiboLabel];
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 230, 60, 20)];
        userNameLabel.text = @"邮箱/手机号";
        userNameLabel.backgroundColor = [UIColor clearColor];
        userNameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:userNameLabel];
        
        
        _userNameField = [UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userNameLabel.frame) + 10, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
    }
    return self;
}

- (void)weiboBtnClick:(id)sender
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://21beizi.com";
    request.scope = @"email,direct_messages_write";
    [WeiboSDK sendRequest:request];
}

@end
