//
//  RPViewController.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPIndexVCTL.h"
#import "RPFrChatIndexVCTL.h"
#import "RPAutoGenSettingVCTL.h"
#import "AutoGen.h"
@interface RPIndexVCTL ()

@end

@implementation RPIndexVCTL

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *holeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [holeBtn addTarget:self action:@selector(holeClick:) forControlEvents:UIControlEventTouchUpInside];
    holeBtn.frame = CGRectMake(0, 0, 100, 44);
    
    [holeBtn setTitle:@"树洞" forState:UIControlStateNormal];
    [self.view addSubview:holeBtn];
    
    
    UIButton *frBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [frBtn addTarget:self action:@selector(frClick:) forControlEvents:UIControlEventTouchUpInside];
    frBtn.frame = CGRectMake(50, 50, 100, 44);
    
    [frBtn setTitle:@"神父" forState:UIControlStateNormal];
    [self.view addSubview:frBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settingBtn addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.frame = CGRectMake(100, 100, 100, 44);
    
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.view addSubview:settingBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)holeClick:(id)sender
{
    
}

- (void)frClick:(id)sender
{
    RPFrChatIndexVCTL *chatVCTL = [[RPFrChatIndexVCTL alloc] init];
    [self.navigationController pushViewController:chatVCTL animated:YES];
}

- (void)settingClick:(id)sender
{
    NSString *path      = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSDictionary *dic   = [[NSDictionary alloc] initWithContentsOfFile:path];
    AutoGen *autoGen    = [[AutoGen alloc] initWithJSONDic:dic];
    RPAutoGenSettingVCTL *settingVCTL = [[RPAutoGenSettingVCTL alloc] init];
    settingVCTL.autoGen = autoGen;
    [self.navigationController pushViewController:settingVCTL animated:YES];
}





@end
