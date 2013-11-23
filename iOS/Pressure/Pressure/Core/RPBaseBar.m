//
//  RPBaseBar.m
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPBaseBar.h"
#define Default_Title_Max_Width 150;

@interface RPBaseBar ()
{
    UILabel *_titleLabel;
    UIButton *_leftBtn;
    UIButton *_rightbtn;
}
@end
@implementation RPBaseBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = Default_LowLow_Gray;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, RPBaseBar_Height/2 - 10, 100, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_highlight_back_webview.png"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_highlight_back_webview.png"] forState:UIControlStateHighlighted];
        _leftBtn.frame = CGRectMake(10, (RPBaseBar_Height - 36)/2, 36, 36);
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        _rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightbtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightbtn];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}


- (void)leftBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(leftButtonClick)])
    {
        [self.delegate leftButtonClick];
    }
}

- (void)rightBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(rightButtonClick)])
    {
        [self.delegate rightButtonClick];
    }
}


@end
