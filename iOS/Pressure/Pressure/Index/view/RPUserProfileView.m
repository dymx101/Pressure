//
//  RPUserProfileVIew.m
//  Pressure
//
//  Created by eason on 11/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPUserProfileView.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
#import "RPProfile.h"
#import "UIImageView+WebCache.h"
#import "RPAppServerOperation.h"
@interface RPUserProfileView ()
{
    UIView      *_insideView;
    UIImageView *_avatarView;
    UITextField *_nickField;
    UIButton    *_maleBtn;
    UIButton    *_femaleBtn;
    UIButton    *_finishedBtn;
}
@end
@implementation RPUserProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        RPAuthModel *authModle = [RPAuthModel sharedInstance];
        RPProfile *profile = authModle.profile;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        _insideView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - RPUserProfileView_Inside_Width)/2, (SCREEN_HEIGHT - RPUserProfileView_Inside_Height)/2, RPUserProfileView_Inside_Width, RPUserProfileView_Inside_Height)];
        _insideView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_insideView];
        
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((RPUserProfileView_Inside_Width - 50)/2, 20, 50, 50)];
        [_avatarView setImageWithURL:URL(profile.avatarUrl) placeholderImage:nil];
        [_insideView addSubview:_avatarView];
        
        _nickField = [[UITextField alloc] initWithFrame:CGRectMake((RPUserProfileView_Inside_Width - 100)/2, CGRectGetMaxY(_avatarView.frame) + 20, 100, 20)];
        _nickField.backgroundColor = [UIColor clearColor];
        _nickField.text = profile.nickName;
        [_insideView addSubview:_nickField];
        
        _maleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _maleBtn.frame = CGRectMake(RPUserProfileView_Inside_Width/4, CGRectGetMaxY(_nickField.frame) + 20, 50, 50);
        [_maleBtn setTitle:@"男" forState:UIControlStateNormal];
        [_maleBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insideView addSubview:_maleBtn];
        
        _femaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_femaleBtn setTitle:@"女" forState:UIControlStateNormal];
        _femaleBtn.frame = CGRectMake(RPUserProfileView_Inside_Width*3/4 - 50, CGRectGetMaxY(_nickField.frame) + 20, 50, 50);
        [_femaleBtn addTarget:self action:@selector(femaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insideView addSubview:_femaleBtn];
        
        _finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
        _finishedBtn.frame = CGRectMake((RPUserProfileView_Inside_Width - 180)/2, CGRectGetMaxY(_femaleBtn.frame) + 20, 180, 44);
        [_finishedBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_insideView addSubview:_finishedBtn];
    }
    return self;
}


- (void)maleBtnClick:(id)sender
{
    
}

- (void)femaleBtnClick:(id)sender
{
    
}

- (void)finishBtnClick:(id)sender
{
    //同步profile
    [self removeFromSuperview];
}
@end
