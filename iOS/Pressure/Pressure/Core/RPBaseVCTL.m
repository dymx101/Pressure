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
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
