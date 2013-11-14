//
//  RPFrChatBar.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatBar.h"
@interface RPFrChatBar ()
{
    UIButton *_talkerBtn;
    UIButton *_fatherBtn;
}
@end

@implementation RPFrChatBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _talkerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _talkerBtn.frame = CGRectMake(80, 10, 50, 50);
        [_talkerBtn setTitle:@"倾诉" forState:UIControlStateNormal];
        [_talkerBtn addTarget:self action:@selector(talkerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_talkerBtn];
        
        
        _fatherBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _fatherBtn.frame = CGRectMake(190, 10, 50, 50);
        [_fatherBtn setTitle:@"神父" forState:UIControlStateNormal];
        [_fatherBtn addTarget:self action:@selector(fatherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fatherBtn];
        
    }
    return self;
}



- (void)talkerBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(rpFrChatBarTalkerBtnClick)])
    {
        [self.delegate rpFrChatBarTalkerBtnClick];
    }
}


- (void)fatherBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(rpFrChatBarFatherBtnClick)])
    {
        [self.delegate rpFrChatBarFatherBtnClick];
    }
}

@end
