//
//  RPForumVCTL.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPForumVCTL.h"
#import "EGORefreshTableHeaderView.h"
#import "UP_EGORefreshTableHeaderView.h"
#import "RPBaseBar.h"
#import "RPServerApiDef.h"
#import "RPForumCell.h"
#import "RPBaseVCTL+Server.h"
#import "RPForum.h"
#import "RPForumCreateVCTL.h"
#define Limit 10
@interface RPForumVCTL () <UP_EGORefreshTableHeaderDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UP_EGORefreshTableHeaderView *_ego;
    EGORefreshTableHeaderView *_topEGO;
    NSMutableArray *_dataSource;
    UITableView *_tv;
    BOOL _isTheEnd;
    BOOL _isLoadOld;
    BOOL _isLoading;
    long long _lastId;
}

@end

@implementation RPForumVCTL

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
    _lastId = -1;
    _isLoading = NO;
    _isTheEnd = NO;
    _isLoadOld = NO;
    _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 - self.bar.frame.size.height, SCREEN_WIDTH, self.contentView.frame.size.height + self.bar.frame.size.height) style:UITableViewStylePlain];
    _tv.dataSource = self;
    _tv.delegate = self;
    [self.contentView addSubview:_tv];
    [self addTableHeader];
    [self addTableFooter];
    
    [self.bar setRightBtnWithText:@"新建"];
    [self performSelector:@selector(serverCallForumList) withObject:nil];
}

- (void)rightButtonClick:(RPBaseBar *)bar
{
    RPForumCreateVCTL *createVCTL = [[RPForumCreateVCTL alloc] init];
    [self presentViewController:createVCTL animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)addTableHeader{
    _topEGO = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0, CGRectGetWidth(_tv.frame), CGRectGetHeight(self.bar.frame))];
    _topEGO.delegate=self;
    [_tv setTableHeaderView:_topEGO];
}

- (void)addTableFooter{
    _ego = [[UP_EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f, 10, 320, 45) withBackgroundColor:[UIColor redColor]];
    _ego.delegate=self;
    _ego.hidden=YES;
    [_tv setTableFooterView:_ego];
}

#pragma mark -
#pragma mark ServerCall
- (void)serverCallForumList
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(Limit), kRPServerRequest_Limit);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(_lastId), kRPServerRequest_BeginTime);
    [self serverCall:kServerApi_Get_Forum_List data:mulDic];
}

- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_Get_Forum_List])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            if (!_isLoadOld)
            {
                [_dataSource removeAllObjects];
                _isTheEnd = NO;
            }
            NSArray *array = serverResp.obj[kMetaKey_ForumList];
            for (NSDictionary *dic in array)
            {
                RPForum *forum = [[RPForum alloc] initWithJSONDic:dic];
                [_dataSource addObject:forum];
            }
            if ([_dataSource count] > 0)
            {
                _lastId = ((RPForum *)[_dataSource lastObject]).forum_id;
            }
            if ([array count] < Limit)
            {
                _isTheEnd = YES;
            }
            if(_isLoadOld){
                [self doneLoadingTableViewData];
            }else{
                [self doneDOWNLoadingTableViewData];
            }
            [_tv reloadData];
        }
        _isLoading = NO;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RPForumCell *forumCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RPForumCell class])];
    
    if (!forumCell)
    {
        forumCell  = [[RPForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([RPForumCell class])];
    }
    
    RPForum *forum = [_dataSource objectAtIndex:indexPath.row];
    [forumCell resetCell:forum index:indexPath.row];
    return forumCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!_isTheEnd)
    {
        [_ego egoRefreshScrollViewDidScroll:scrollView];
    }
    [_topEGO egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!_isTheEnd){
        [_ego egoRefreshScrollViewDidEndDragging:scrollView];
    }
    [_topEGO egoRefreshScrollViewDidEndDragging:scrollView changeInset:YES];
    if(!decelerate){
        
    }
}

#pragma mark - EGO delegate
- (void)reloadTableViewDataSource
{
    if(!_isTheEnd){
        _isLoadOld=YES;
        _lastId = -1;
        [self serverCallForumList];
    }
}

- (void)doneLoadingTableViewData
{
    if(!_isTheEnd){
        [_ego egoRefreshScrollViewDataSourceDidFinishedLoading:_tv];
    }
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(UP_EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(UP_EGORefreshTableHeaderView*)view{
	
	return _isLoading;
}

#pragma mark - DownEGO
- (void)doneDOWNLoadingTableViewData{
	
	//  model should call this when its done loading
	[_topEGO egoRefreshScrollViewDataSourceDidFinishedLoading:_tv changeInset:YES];
}

- (void)downEGOReload
{
    if(!_isLoading)
    {
        _isLoadOld=NO;
        [self serverCallForumList];
    }
}

- (void)down_egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self downEGOReload];
}

- (BOOL)down_egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _isLoading;
}


#pragma mark -
#pragma mark RPForumCell Delegate
- (void)rpForumCellHelpBtnClick:(int)index
{
    RPForum *forum = [_dataSource objectAtIndex:index];
    
}


@end
