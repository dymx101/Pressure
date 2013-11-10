//
//  RPFrAvatarBar.m
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrAvatarBar.h"
#import "UIButton+WebCache.h"
#import "RPProfile.h"
#define Default_Btn_Width 35
#define Default_Label_Width 55
#define Default_Label_Height 25
@interface RPFrAvatarBar ()
{
    UIButton *_avatarBtn;
    UILabel  *_nickLabel;
    UILabel  *_countLabel;
}

@end
@implementation RPFrAvatarBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.frame  = CGRectMake(5, 5, Default_Btn_Width, Default_Btn_Width);
        [self addSubview:_avatarBtn];
        
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_avatarBtn.frame) + 5 , 10, Default_Label_Width, Default_Label_Height)];
        _nickLabel.backgroundColor = [UIColor clearColor];
        _nickLabel.textAlignment   = NSTextAlignmentLeft;
        _nickLabel.font  = [UIFont systemFontOfSize:12];
        _nickLabel.textColor    = Default_Medium_Gray;
        [self addSubview:_nickLabel];
    }
    return self;
}

- (void)resetAvatarBar:(RPProfile *)profile
{
    if (!profile)
    {
        return;
    }
    [_avatarBtn setImageWithURL:URL(profile.avatarUrl) forState:UIControlStateNormal placeholderImage:nil];
    [_avatarBtn setImageWithURL:URL(profile.avatarUrl) forState:UIControlStateHighlighted placeholderImage:nil];
    _nickLabel.text = profile.nickName;
}



@end
