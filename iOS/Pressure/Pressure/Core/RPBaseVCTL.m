//
//  RPBaseVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPBaseVCTL.h"
#import "RPBaseBar.h"
@interface RPBaseVCTL ()<RPBaseBarDelegate>
{
    
}

@end

@implementation RPBaseVCTL

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat originHeight = 0 ;
    if (!_hideHeaderBar)
    {
        _bar = [[RPBaseBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEADER_HEIGHT)];
        _bar.delegate = self;
        [self.view addSubview:_bar];
        originHeight = SCREEN_HEADER_HEIGHT;
    }
    
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, originHeight, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - originHeight)];
        [self.view addSubview:_contentView];
    }
    
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, originHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.hidden = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapGesture:)];
        [_maskView addGestureRecognizer:tapGesture];
        [self.view addSubview:_maskView];
    }
    [self.view bringSubviewToFront:_bar];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)backToPrefix
{
    
    UINavigationController * ctr = [self navigationController];
    if (ctr)
    {
        if ([ctr topViewController] == [ctr visibleViewController] && [[ctr viewControllers] count] > 1)
		{
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else {
            [self dismissViewControllerAnimated:YES completion:nil];
	}
}


- (void)maskViewTapGesture:(UITapGestureRecognizer *)gesture
{
    
}


#pragma mark -
#pragma mark RPBaseBar
- (void)leftButtonClick:(RPBaseBar *)bar
{
    [self backToPrefix];
}

- (void)rightButtonClick:(RPBaseBar *)bar
{
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
