//
//  RPUserProfileHeaderView.m
//  Pressure
//
//  Created by eason on 11/12/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPUserProfileHeaderView.h"
#import "RPProfile.h"
#import "UIImageView+WebCache.h"
@interface RPUserProfileHeaderView ()
{
    UIButton *_nickBtn;
    UIImageView *_avatarImageView;
    
}
@end
@implementation RPUserProfileHeaderView

- (id)initWithFrame:(CGRect)frame profile:(RPProfile *)profile;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_avatarImageView setImageWithURL:URL(profile.avatarUrl) placeholderImage:nil];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImageViewTap:)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.userInteractionEnabled = YES;
        [_avatarImageView addGestureRecognizer:tapGesture];
        _avatarImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:_avatarImageView];
        
        _nickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nickBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 40, 200, 20);
        _nickBtn.backgroundColor = [UIColor clearColor];
        [_nickBtn setTitle:@"郑医生" forState:UIControlStateNormal];
        [_nickBtn setTitle:@"郑医生" forState:UIControlStateHighlighted];
        _nickBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_nickBtn];
    }
    return self;
}


- (void)avatarImageViewTap:(UITapGestureRecognizer *)gesture
{
    
}


@end
