//
//  RPProfileView.m
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPProfileView.h"
#import "SVSegmentedControl.h"
#import "TSLocateView.h"
#import "RPProfile.h"
#import "GradientButton.h"
@interface RPProfileView ()
{
    UIButton *_femaleBtn;
    UIButton *_maleBtn;
    UILabel  *_cityLabel;
    RPProfile *_profile;
}
@end

@implementation RPProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _profile = [[RPProfile alloc] init];
        
        _femaleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _femaleBtn.frame = CGRectMake(100, 100, 44, 44);
        [_femaleBtn setTitle:@"女" forState:UIControlStateNormal];
        [_femaleBtn addTarget:self action:@selector(femaleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_femaleBtn];
        
        _maleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _maleBtn.frame = CGRectMake(160+10, 100, 44, 44);
        [_maleBtn setTitle:@"男" forState:UIControlStateNormal];
        [_maleBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maleBtn];
        
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 100, 30)];
        _cityLabel.backgroundColor = [UIColor redColor];
        _cityLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityClick:)];
        [_cityLabel addGestureRecognizer:gesture];
        _cityLabel.text = @"城市";
        
        GradientButton *finishedBtn = [[GradientButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cityLabel.frame), CGRectGetMaxY(_cityLabel.frame) + 10, CGRectGetWidth(_cityLabel.frame), CGRectGetHeight(_cityLabel.frame))];
        [finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishedBtn setTitle:@"完成" forState:UIControlStateHighlighted];
        [finishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        finishedBtn.normalGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        finishedBtn.normalGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        finishedBtn.highlightGradientColors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0xff6b00) CGColor],(id)[UIColorFromRGB(0xf86700) CGColor], nil];
        finishedBtn.highlightGradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.1], nil];
        [self addSubview:finishedBtn];
        
        
    }
    return self;
}

- (void)femaleBtnClick:(id)sender
{
    _profile.gender = RPProfile_Gender_Female;
}

- (void)maleBtnClick:(id)sender
{
    _profile.gender = RPProfile_Gender_Male;
}

- (void)cityClick:(id)sender
{
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    [locateView showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        _cityLabel.text = location.city;
        _profile.city = location.city;
    }
}

- (void)finishedBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(rpProfileViewDidSelect:)])
    {
        [self.delegate rpProfileViewDidSelect:_profile];
    }
}



@end
