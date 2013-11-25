//
//  RPLoginVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-28.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPLoginVCTL.h"

#import "RPAuthModel.h"
#import "RPIndexVCTL.h"
#import "RPLoginView.h"
#import "RPProfileView.h"
#import "RPRegisterView.h"
@interface RPLoginVCTL () <RPLoginViewDelegate,RPProfileViewDelegate,RPRegisterViewDelegate>
{
    UIScrollView *_scrollView;
}

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
    self.hideHeaderBar = YES;
    [super viewDidLoad];
    
    [self.contentView removeFromSuperview];
    
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR*3)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR*3);
        _scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR);
        [self.view addSubview:_scrollView];
    }
    
    RPRegisterView *registerView = [[RPRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    registerView.delegate = self;
    [_scrollView addSubview:registerView];
    
    RPLoginView *loginView = [[RPLoginView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    loginView.delegate = self;
    [_scrollView addSubview:loginView];
    
    RPProfileView *profileView = [[RPProfileView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR*2, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    profileView.delegate = self;
    [_scrollView addSubview:profileView];
    
    
        

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThirdPartLoginSuccNotif:) name:kNotif_ThirdPartLoginSucc object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark -
#pragma mark ThirdPartLogin
- (void)handleThirdPartLoginSuccNotif:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_LoginSucc object:nil];
}

@end
