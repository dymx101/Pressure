//
//  RPFrFilterDialog.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrFilterDialog.h"
#import "RPProfile.h"
#import "RPSearchType.h"
#import "SVSegmentedControl.h"
#import "RPAuthModel.h"
#import "RPAppServerOperation.h"
#import "RPPickerView.h"
@interface RPFrFilterDialog ()
{
    UILabel     *_descLabel;
    UIButton    *_ageBtn;
    UIButton    *_cityBtn;
    UIButton    *_chatTypeBtn;
    NSArray     *_chatTypes;
    BOOL         _gotChatTypes;
    RPFrFilterDialog_Type _type;
    
}
@end
@implementation RPFrFilterDialog

- (id)initWithDelegate:(id <CustomDialogDelegate>)delegate type:(RPFrFilterDialog_Type)type
{
    self = [super initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 50*2) delegate:delegate imageNameStr:nil okBtnFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 50*2 - 80, 100, 44) okBtnImageNameStr:@"tck_nan" cancelBtnFrame:CGRectZero cancelBtnImageNameStr:nil];
    if (self)
    {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        
        _searchType = [[RPSearchType alloc] init];
        RPAuthModel *authModel = [RPAuthModel sharedInstance];
        RPProfile *profile = authModel.profile;
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 20)];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.text = @"亲爱的神父，我希望您满足...";
        [self addSubview:_descLabel];
        
        
        SVSegmentedControl *genderSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"男",@"女", nil]];
        [self addSubview:genderSC];
        genderSC.center = CGPointMake(self.center.x, CGRectGetMaxY(_descLabel.frame) + 40);
        __block RPSearchType *weakSearchType = _searchType;
        genderSC.changeHandler = ^(NSUInteger newIndex) {
            weakSearchType.gender = newIndex == 0?RPProfile_Gender_Male:RPProfile_Gender_Female;
        };
        
        _ageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _ageBtn.frame = CGRectMake(0, CGRectGetMaxY(genderSC.frame) + 40, 100, 44);
        [_ageBtn addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ageBtn setTitle:STR(profile.age) forState:UIControlStateNormal];
        [_ageBtn setTitle:STR(profile.age) forState:UIControlStateHighlighted];
        [self addSubview:_ageBtn];
        
//        _cityBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        _cityBtn.frame = CGRectMake(0, CGRectGetMaxY(_ageBtn.frame), 100, 44);
//        [_cityBtn addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_cityBtn setTitle:profile.city forState:UIControlStateNormal];
//        [_cityBtn setTitle:profile.city forState:UIControlStateHighlighted];
//        [self addSubview:_cityBtn];
        
        _chatTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _chatTypeBtn.frame = CGRectMake(0, CGRectGetMaxY(_ageBtn.frame), 100, 44);
        [_chatTypeBtn addTarget:self action:@selector(chatTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chatTypeBtn];
        [self resetChatTypeBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleGetChatTypesNotif:) name:kNotif_GetChatTypesSucc object:nil];
        
        [self performSelector:@selector(serverCallGetType) withObject:nil];
    }
    return self;
}


- (void)resetChatTypeBtn
{
    if (_gotChatTypes)
    {
        [_chatTypeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_chatTypeBtn setTitle:@"请选择" forState:UIControlStateHighlighted];
    }else
    {
        [_chatTypeBtn setTitle:@"正在获取" forState:UIControlStateNormal];
        [_chatTypeBtn setTitle:@"正在获取" forState:UIControlStateHighlighted];
    }
}

- (void)serverCallGetType
{
    [[RPAppServerOperation sharedRPAppServerOperation] asynServerCallChatType];
}

- (void)dialogDidSucceed
{
    if (!_gotChatTypes)
    {
        return;
    }
    [super dialogDidSucceed];
}

- (void)ageBtnClick:(id)sender
{
    _searchType.ageRange = @"17~24";
}

- (void)cityBtnClick:(id)sender
{
    _searchType.city = @"杭州";
}

- (void)chatTypeBtnClick:(id)sender
{
    if (_gotChatTypes)
    {
        if ([_chatTypes count] >0)
        {
            _searchType.chatType = [_chatTypes objectAtIndex:0];
        }
    }
}

- (void)handleGetChatTypesNotif:(NSNotification*)notif
{
    _gotChatTypes = YES;
    NSDictionary *userInfo = notif.userInfo;
    if (!userInfo)
    {
        return;
    }
    _chatTypes = [userInfo objectForKey:kNotif_GetChatTypesSucc_UserInfo];
    
    [self resetChatTypeBtn];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
