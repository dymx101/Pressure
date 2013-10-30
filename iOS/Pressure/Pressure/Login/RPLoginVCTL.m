//
//  RPLoginVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-28.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPLoginVCTL.h"
#import "WeiboSDK.h"
#import "RPIndexVCTL.h"
@interface RPLoginVCTL ()

@end

@implementation RPLoginVCTL

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
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"接入新浪微博" forState:UIControlStateNormal];
    [btn setTitle:@"接入新浪微博" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame =  CGRectMake(0, 0, 100, 44);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginBtnClick:(id)sender
{
    RPIndexVCTL *indexVCTL = [[RPIndexVCTL alloc] init];
    [self.navigationController pushViewController:indexVCTL animated:YES];
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = @"http://21beizi.com";
//    request.scope = @"email,direct_messages_write";
//    [WeiboSDK sendRequest:request];
}

@end
