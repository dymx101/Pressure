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
#import "RPProfile.h"
#import "RPProfileView.h"
#import "RPBaseVCTL+Server.h"
#import "RPRegisterView.h"
#import "RPServerApiDef.h"
#import "NSString+Addition.h"
#import "BlockAlertView.h"
typedef enum _RPLoginVCTL_Type
{
    RPLoginVCTL_Type_Register,
    RPLoginVCTL_Type_Login,
    RPLoginVCTL_Type_UpdateProfile
}RPLoginVCTL_Type;

@interface RPLoginVCTL () <RPLoginViewDelegate,RPRegisterViewDelegate,RPProfileViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    RPLoginVCTL_Type _nowType;
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR*3);
        [self.view addSubview:_scrollView];
    }
    
    if ([[RPAuthModel sharedInstance] logined] && [RPAuthModel sharedInstance].profile.gender < 0)
    {
        _nowType = RPLoginVCTL_Type_UpdateProfile;
    }else
    {
        _nowType = RPLoginVCTL_Type_Login;
        
    }
    [self resetScrollView:NO];
    
    __block RPLoginVCTL *weakSelf = self;
    RPRegisterView *registerView = [[RPRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    registerView.delegate = self;
    [registerView setCancelBlock:^{
        _nowType = RPLoginVCTL_Type_Login;
        [weakSelf resetScrollView:YES];
    }];
    [_scrollView addSubview:registerView];
    
    RPLoginView *loginView = [[RPLoginView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    loginView.delegate = self;
    
    [loginView setRegisterBlock:^{
        _nowType = RPLoginVCTL_Type_Register;
        [weakSelf resetScrollView:YES];
    }];
    [_scrollView addSubview:loginView];
    
    RPProfileView *profileView = [[RPProfileView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR*2, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR)];
    profileView.delegate = self;
    
    [_scrollView addSubview:profileView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThirdPartLoginSuccNotif:) name:kNotif_ThirdPartLoginSucc object:nil];
    
}

/**
 *  重置scrollview
 */
- (void)resetScrollView:(BOOL)animated
{
    CGFloat originY = 0;
    switch (_nowType) {
        case RPLoginVCTL_Type_Register:
        {
            originY = 0;
        }
            break;
        case RPLoginVCTL_Type_Login:
        {
            originY = SCREEN_HEIGHT_WITHOUT_STATUS_BAR;
        }
            break;
        case RPLoginVCTL_Type_UpdateProfile:
        {
            originY = SCREEN_HEIGHT_WITHOUT_STATUS_BAR*2;
        }
            break;
        default:
            break;
    }
    if (animated)
    {
        __block UIScrollView *weakScrollView  = _scrollView;
        [UIView animateWithDuration:0.8 animations:^{
            weakScrollView.contentOffset = CGPointMake(0, originY);
        }];
    }else
    {
        _scrollView.contentOffset = CGPointMake(0, originY);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goToUpdateUserProfileOrLoginSucc
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (authModel.profile.gender < 0)
    {
        _nowType = RPLoginVCTL_Type_UpdateProfile;
        [self resetScrollView:YES];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotif_LoginSucc object:nil];
    }
}

#pragma mark -
#pragma mark ServerCall
- (void)serverCallLogin:(NSString *)userName passWord:(NSString *)passWord
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(userName), kRPServerRequest_UserName);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(passWord), kRPServerRequest_PassWord);
    [self serverCall:kServerApi_Login data:mulDic];
}

- (void)serverCallRegister:(NSString *)userName passWord:(NSString *)passWord
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(userName), kRPServerRequest_UserName);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(passWord), kRPServerRequest_PassWord);
    [self serverCall:kServerApi_RegisterUser data:mulDic];
}

- (void)serverCallUpdateProfile
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(authModel.profile.nickName), kRPServerRequest_NickName);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(authModel.profile.gender), kRPServerRequest_Gender);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(authModel.profile.avatarUrl), kRPServerRequest_AvatarUrl);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(authModel.profile.city), kRPServerRequest_City);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(authModel.profile.age), kRPServerRequest_Age);
    [self serverCall:kServerApi_UpdateUserProfile data:mulDic];
}

- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_Login])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPAuthModel *authModel = [RPAuthModel sharedInstance];
            [authModel setLoginSuccValue:serverResp.obj];
            [authModel saveData];
            [self goToUpdateUserProfileOrLoginSucc];
        }
    }
    
    if ([serverResp.operationType isEqualToString:kServerApi_RegisterUser])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPAuthModel *authModel = [RPAuthModel sharedInstance];
            [authModel setLoginSuccValue:serverResp.obj];
            [authModel saveData];
            [self goToUpdateUserProfileOrLoginSucc];
        }else if (serverResp.code == RPServerResponseCode_UserRegistered)
        {
            BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:nil message:@"用户名已被注册"];
            [alertView setCancelButtonWithTitle:@"知道了" block:nil];
            [alertView show];
        }else
        {
            BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:nil message:@"注册失败,请稍后再试"];
            [alertView setCancelButtonWithTitle:@"知道了" block:nil];
            [alertView show];
        }
    }
    if ([serverResp.operationType isEqualToString:kServerApi_UpdateUserProfile])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPAuthModel *authModel = [RPAuthModel sharedInstance];
            [authModel saveData];
            [self goToUpdateUserProfileOrLoginSucc];
        }
    }
}

#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_nowType == RPLoginVCTL_Type_Login && scrollView.contentOffset.y > SCREEN_HEIGHT_WITHOUT_STATUS_BAR)
    {
        [self resetScrollView:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate)
    {
        return;
    }
    if (_nowType == RPLoginVCTL_Type_Login && scrollView.contentOffset.y < SCREEN_HEIGHT_WITHOUT_STATUS_BAR*1/2)
    {
        _nowType = RPLoginVCTL_Type_Register;
    }else if (_nowType == RPLoginVCTL_Type_Register && scrollView.contentOffset.y > SCREEN_HEIGHT_WITHOUT_STATUS_BAR*1/2)
    {
        _nowType = RPLoginVCTL_Type_Login;
    }
    [self resetScrollView:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (_nowType == RPLoginVCTL_Type_Login && scrollView.contentOffset.y < SCREEN_HEIGHT_WITHOUT_STATUS_BAR)
    {
        _nowType = RPLoginVCTL_Type_Register;
    }else if (_nowType == RPLoginVCTL_Type_Register && scrollView.contentOffset.y > 0)
    {
        _nowType = RPLoginVCTL_Type_Login;
    }
    [self resetScrollView:YES];
}

#pragma mark -
#pragma mark ThirdPartLogin
- (void)handleThirdPartLoginSuccNotif:(NSNotification *)notif
{
    [self goToUpdateUserProfileOrLoginSucc];
}


#pragma mark -
#pragma mark RPLoginView Delegate
- (void)rpLoginViewLogin:(NSString*)userName passWord:(NSString *)passWord
{
    if (!userName || !passWord || [userName isEmpty] || [passWord isEmpty])
    {
        BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:nil message:@"账号或者密码不能为空"];
        [alertView setCancelButtonWithTitle:@"知道了" block:nil];
        [alertView show];
        return;
    }
    [self serverCallLogin:userName passWord:passWord];
}

#pragma mark -
#pragma mark RPRegisterView Delegate
- (void)rpRegisterViewRegister:(NSString *)userName pass:(NSString *)pass
{
    [self serverCallRegister:userName passWord:pass];
}

#pragma mark -
#pragma mark RPProfileView Delegate
- (void)rpProfileViewDidSelect:(RPProfile *)profile
{
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    authModel.profile.gender = profile.gender;
    authModel.profile.city = profile.city;
    authModel.profile.age = profile.age;
    authModel.profile.nickName = profile.nickName;
    authModel.profile.avatarUrl = profile.avatarUrl;
    [self serverCallUpdateProfile];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
