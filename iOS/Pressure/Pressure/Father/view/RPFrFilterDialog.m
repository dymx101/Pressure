//
//  RPFrFilterDialog.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrFilterDialog.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
@interface RPFrFilterDialog ()
{
    UILabel     *_descLabel;
    UIButton    *_genderBtn;
    UIButton    *_ageBtn;
    UIButton    *_cityBtn;
    UIButton    *_thingsBtn;
}
@end
@implementation RPFrFilterDialog

- (id)initWithDelegate:(id <CustomDialogDelegate>)delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR) delegate:delegate imageNameStr:nil okBtnFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 300, 100, 44) okBtnImageNameStr:@"tck_nan" cancelBtnFrame:CGRectZero cancelBtnImageNameStr:nil];
    if (self)
    {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 280, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 100)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [self sendSubviewToBack:bgView];
        
        RPAuthModel *authModel = [RPAuthModel sharedInstance];
        RPProfile *profile = authModel.profile;
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.text = @"亲爱的神父，我希望您满足...";
        [bgView addSubview:_descLabel];
        
        _genderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _genderBtn.frame = CGRectMake(0, CGRectGetMaxY(_descLabel.frame) + 5, 100, 44);
        [_genderBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_genderBtn setTitle:[profile genderStr] forState:UIControlStateNormal];
        [_genderBtn setTitle:[profile genderStr] forState:UIControlStateHighlighted];
        [bgView addSubview:_genderBtn];
        
        _ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ageBtn.frame = CGRectMake(0, CGRectGetMaxY(_genderBtn.frame), 100, 44);
        [_ageBtn addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ageBtn setTitle:STR(profile.age) forState:UIControlStateNormal];
        [_ageBtn setTitle:STR(profile.age) forState:UIControlStateHighlighted];
        [bgView addSubview:_ageBtn];
        
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityBtn.frame = CGRectMake(0, CGRectGetMaxY(_ageBtn.frame), 100, 44);
        [_cityBtn addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setTitle:STR(profile.age) forState:UIControlStateNormal];
        [_cityBtn setTitle:STR(profile.age) forState:UIControlStateHighlighted];
        [bgView addSubview:_cityBtn];
        
        _thingsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _thingsBtn.frame = CGRectMake(0, CGRectGetMaxY(_cityBtn.frame), 100, 44);
        [_thingsBtn addTarget:self action:@selector(thingsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_thingsBtn setTitle:@"aa" forState:UIControlStateNormal];
        [_thingsBtn setTitle:@"aa" forState:UIControlStateHighlighted];
        [bgView addSubview:_thingsBtn];
    }
    return self;
}


- (void)genderBtnClick:(id)sender
{
    
}

- (void)ageBtnClick:(id)sender
{
    
}

- (void)cityBtnClick:(id)sender
{
    
}

- (void)thingsBtnClick:(id)sender
{
    
}
@end
