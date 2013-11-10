//
//  RPBaseVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPBaseVCTL.h"

@interface RPBaseVCTL ()

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
    
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTapGesture:)];
        [_maskView addGestureRecognizer:tapGesture];
        [self.view addSubview:_maskView];
    }
    
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

@end
