//
//  RPFrChatVCTL.m
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatVCTL.h"
#import "EGORefreshTableHeaderView.h"
#import "RPFrChatCell.h"
#import "RPProfile.h"
#import "RPAppModel.h"
#import "RPXmppProfile.h"
#import "RPAuthModel.h"
#import "RPFrChatTextCell.h"
#import "RPXmppManager.h"
#import "JSON20.h"
#import "RPMessage.h"
#import "RPInputView.h"
@interface RPFrChatVCTL () <UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,RPInputViewDelegate>
{
    UITableView *_tv;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSMutableArray *_dataSource;
    RPInputView *_inputView;
    RPProfile *_chatingUser;
}

@end

@implementation RPFrChatVCTL

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
    
    _dataSource = [[NSMutableArray alloc] init];
    _chatingUser = [[RPAppModel sharedInstance] chatingUser];
    if (!_tv)
    {
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - kRPInputView_Up_Height) style:UITableViewStylePlain];
        _tv.dataSource = self;
        _tv.delegate = self;
        _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tv];
    }
    
    if (_refreshHeaderView == nil)
    {
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
		_refreshHeaderView.delegate = self;
		[_tv addSubview:_refreshHeaderView];
	}
    
    if (!_inputView)
    {
        _inputView = [[RPInputView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_WITHOUT_STATUS_BAR - kRPInputView_Up_Height, SCREEN_WIDTH, kRPInputView_Up_Height + Default_KeyBoardHeight)];
        _inputView.delegate = self;
        [self.view addSubview:_inputView];
    }
    
    [self resetChatArray];
    [self resetTableViewFrame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppTalkingMessageNotif:) name:kNotif_XmppTalkingMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUIKeyBoardWillHideNotif:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUIKeyBoardWillShowNotif:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetChatArray
{
    @synchronized(self)
    {
        RPAuthModel *authModel = [RPAuthModel sharedInstance];
        NSArray *messages = [RPMessage messageFromDB:_chatingUser.userId toUserId:authModel.profile.userId dbId:-1];
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:messages];
        [_tv reloadData];
    }
}

- (void)addNewChatToArray:(id)obj
{
    @synchronized(self)
    {
        [_tv beginUpdates];
        [_dataSource addObject:obj];
        [_tv insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:([_dataSource count]-1) inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        [_tv endUpdates];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [_dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[RPMessage class]])
    {
        NSString *text = ((RPMessage *)obj).content;
        return [RPFrChatTextCell cellHeight:text];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [_dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[RPMessage class]])
    {
        RPFrChatTextCell *cell = (RPFrChatTextCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
        if (!cell)
        {
            cell = [[RPFrChatTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell resetCellWithMessage:(RPMessage *)obj];
        return cell;
    }
    return nil;
}

- (void)resetTableViewFrame
{
    _tv.frame = CGRectMake(0, 0, CGRectGetWidth(_tv.frame), _inputView.frame.origin.y);
    [_tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([_dataSource count]-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tv];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
    //停止加载，弹回下拉
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];

}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark NSNotificationCenter
- (void)handleXmppTalkingMessageNotif:(NSNotification *)notif
{
    NSDictionary *userInfo = notif.userInfo;
    if (!userInfo)
    {
        return;
    }
    long long userId = [[userInfo objectForKey:[RPMessage rpMessageUserIdKey]] longLongValue];
    //如果是当前聊天用户，重画一下
    if (_chatingUser.userId == userId)
    {
        [self resetChatArray];
    }else
    {
        //增加计数
    }
}

- (void)handleUIKeyBoardWillHideNotif:(NSNotification *)notif
{
    [_inputView rpInputViewHide];
    
}

- (void)handleUIKeyBoardWillShowNotif:(NSNotification *)notif
{
    [_inputView rpInputViewShow];
    CGRect frame = _tv.frame;
    frame.size.height -= Default_KeyBoardHeight;
    _tv.frame = frame;
    [_tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([_dataSource count]-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

#pragma mark -
#pragma mark RPInputView Delegate
- (void)rpInputViewWillShow
{
    self.maskView.hidden = NO;
    self.maskView.frame = CGRectMake(0, 0, CGRectGetWidth(self.maskView.frame), _inputView.frame.origin.y);
   // [self resetTableViewFrame];
    [self.view bringSubviewToFront:self.maskView];
}

- (void)rpInputViewWillHide
{
    [self resetTableViewFrame];
    self.maskView.hidden = YES;
}

- (void)rpInputViewWillChangeHeight
{
    if (!self.maskView.hidden)
    {
       self.maskView.frame = CGRectMake(0, 0, CGRectGetWidth(self.maskView.frame), _inputView.frame.origin.y);
    }
    [self resetTableViewFrame];
}

- (void)rpInputViewTextEnd:(NSString *)text
{
    RPMessage *message = [[RPMessage alloc] init];
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    message.userId = authModel.profile.userId;
    message.toUserId = _chatingUser.userId;
    message.content = SAFESTR(text);
    message.readed  = RPMessage_ReadState_Readed;
    message.img_url = @"";
    message.voice_url = @"";
    message.type = RPMessage_Type;
    [message saveToDB];
    [[RPXmppManager sharedInstance] sendMessage:[[message proxyForJson] JSONRepresentation] toUser:_chatingUser.xmppProfile];
    [self addNewChatToArray:message];
}

- (void)maskViewTapGesture:(UITapGestureRecognizer *)gesture
{
    [super maskViewTapGesture:gesture];
    [_inputView rpInputViewHide];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
