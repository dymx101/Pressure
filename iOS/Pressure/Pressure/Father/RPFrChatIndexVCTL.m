//
//  RPFrChatVCTL.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPFrChatIndexVCTL.h"
#import "RPXmppManager.h"
#import "RPProfile.h"
#import "MMProgressHUD.h"
#import "RPFrChatModel.h"
#import "RPSearchType.h"
#import "RPChat.h"
#import "RPAuthModel.h"
#import "RPServerApiDef.h"
#import "RPBaseVCTL+Server.h"
#import "RPChatType.h"
#import "RPFrChatVCTL.h"
#import "RPAppModel.h"
#import "RPFrFilterDialog.h"
#import "BlockAlertView.h"
#define kLimit 20
@interface RPFrChatIndexVCTL () <CustomDialogDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tv;
    RPChat_VisitUserType _type;
    long long _updateTime;
    BOOL _isEnd;
}

@end

@implementation RPFrChatIndexVCTL

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _type = RPChat_VisitUserType_Father;
    _updateTime = -1;
    _isEnd = NO;
    if (!_tv)
    {
        _tv = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tv.delegate = self;
        _tv.dataSource = self;
        [self.contentView addSubview:_tv];
    }
    
    UIButton *asTalkerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [asTalkerBtn addTarget:self action:@selector(asTalkerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    asTalkerBtn.frame = CGRectMake(50, 50, 100, 44);
    [asTalkerBtn setTitle:@"找神父" forState:UIControlStateNormal];
    [self.contentView addSubview:asTalkerBtn];
    
    UIButton *asFatherBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [asFatherBtn addTarget:self action:@selector(asFatherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    asFatherBtn.frame = CGRectMake(100, 100, 100, 44);
    [asFatherBtn setTitle:@"做神父" forState:UIControlStateNormal];
    [self.contentView addSubview:asFatherBtn];
    //如果是0，取一次
    if ([[RPFrChatModel sharedInstance].fatherChats count] ==0)
    {
        [self performSelector:@selector(serverCallUserChatingList) withObject:nil];
    }else
    {
        [_tv reloadData];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppTalkingMessageNotif:) name:kNotif_XmppTalkingMessage object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)asTalkerBtnClick:(id)sender
{
    RPFrFilterDialog *dialog = [[RPFrFilterDialog alloc] initWithDelegate:self type:RPFrFilterDialog_Type_Find_Father];
    [dialog show];
}

- (void)asFatherBtnClick:(id)sender
{
    [self serverCallAsFather];
}

#pragma mark -
#pragma mark Server
- (void)serverCallAsFather
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    RPProfile *profile = authModel.profile;
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, @"17~24", kRPServerRequest_AgeRange);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(profile.gender), kRPServerRequest_Gender);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(1), kRPServerRequest_ChatType);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(RPChat_VisitUserType_Father), kRPServerRequest_Type);
    [self serverCall:kServerApi_UpdateMatchType data:mulDic];
}

- (void)serverCallFrMatch:(RPSearchType *)searchType
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(searchType.ageRange), kRPServerRequest_AgeRange);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(searchType.gender), kRPServerRequest_Gender);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(searchType.chatType.dbId), kRPServerRequest_ChatType);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(searchType.city), kRPServerRequest_City);
    [self serverCall:kServerApi_FrMatch data:mulDic];
}

- (void)serverCallUserChatingList
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(_type), kRPServerRequest_Type);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(kLimit), kRPServerRequest_Limit);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(_updateTime), kRPServerRequest_UpdateTime);
    RPServerRequest *serverReq =  [[RPServerOperation sharedInstance] generateDefaultServerRequest:self operationType:kServerApi_SyncUserChatingUsers dic:mulDic];
    [[RPServerOperation sharedInstance] syncToServerByRequest:serverReq];
}


- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_FrMatch])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPChat *chat = [[RPChat alloc] initWithJSONDic:serverResp.obj[kMetaKey_Chat]];
            
            RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
            chatModel.type  = RPChat_VisitUserType_Father;
            [chatModel addFatherChatAtIndex:chat index:0];
            
            RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] initWithNowChat:chat];
            [self.navigationController pushViewController:chatVCTL animated:YES];
        }else if (serverResp.code == RPServerResponseCode_FatherUserNotFound)
        {
            BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:nil message:@"神父不在噢~"];
            [alertView setCancelButtonWithTitle:@"取消" block:nil];
            [alertView show];
        }else
        {
            BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:nil message:@"服务器错误"];
            [alertView setCancelButtonWithTitle:@"取消" block:nil];
            [alertView show];
        }
    }
    if ([serverResp.operationType isEqualToString:kServerApi_UpdateMatchType])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            
        }
    }
    if ([serverResp.operationType isEqualToString:kServerApi_SyncUserChatingUsers])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
            NSArray *serverChats ;
            if (_type == RPChat_VisitUserType_Father)
            {
                serverChats = [serverResp.obj objectForKey:kMetaKey_Father_List];
            }else
            {
                serverChats = [serverResp.obj objectForKey:kMetaKey_Talker_List];
            }
            if ([serverChats count] < kLimit)
            {
                _isEnd = YES;
            }
            if (_updateTime < 0)
            {
                if (_type == RPChat_VisitUserType_Father)
                {
                    [chatModel removeAllFatherChats];
                }else
                {
                    [chatModel removeAllTalkerChats];
                }
            }
            for (NSDictionary *dic in serverChats)
            {
                RPChat *chat = [[RPChat alloc] initWithJSONDic:dic[kMetaKey_Chat]];
                if (_type == RPChat_VisitUserType_Talker)
                {
                    [chatModel addTalkerChatAtIndex:chat index:-1];
                }else
                {
                    [chatModel addFatherChatAtIndex:chat index:-1];
                }
            }
            if (_type == RPChat_VisitUserType_Talker)
            {
                _updateTime = ((RPChat*)[chatModel.talkerChats lastObject]).update_time;
            }else
            {
                _updateTime = ((RPChat*)[chatModel.fatherChats lastObject]).update_time;
            }
            [_tv reloadData];
        }
    }
}

#pragma mark -
#pragma mark CustomDialog Delegate
- (void)dialogDidComplete:(CustomDialog *)dialog
{
    RPSearchType *searchType = ((RPFrFilterDialog *)dialog).searchType;
    [self serverCallFrMatch:searchType];
}

- (void)dialogDidNotComplete:(CustomDialog *)dialog
{
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
    if (_type == RPChat_VisitUserType_Talker)
    {
        return [chatModel.talkerChats count];
    }else
    {
        return [chatModel.fatherChats count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RPFrChatModel *chatModel = [RPFrChatModel sharedInstance];
    RPChat *chat ;
    if (_type == RPChat_VisitUserType_Talker)
    {
        chat = [chatModel.talkerChats objectAtIndex:indexPath.row];
    }else
    {
        chat = [chatModel.fatherChats objectAtIndex:indexPath.row];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.textLabel.text = LONGLONG2STR(chat.profile.userId);
    return cell;
}



@end
