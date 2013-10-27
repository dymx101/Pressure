//
//  RPViewController.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPIndexVCTL.h"
#import "RPFrChatVCTL.h"
@interface RPIndexVCTL ()

@end

@implementation RPIndexVCTL

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 100, 44);
    btn.center = self.view.center;
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)btnClick:(id)sender
{
    RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] init];
    [self.navigationController pushViewController:chatVCTL animated:YES];
}





@end
