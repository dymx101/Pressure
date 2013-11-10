//
//  AEAutoGenSettingVCTL.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "AutoGenSettingVCTL.h"
#import "AutoGen.h"
#import "AutoGenSection.h"
#import "AutoGenCell.h"
#import "AutoGenCellHeader.h"
#import "RPSectionHeaderView.h"
#import "AutoGenViewCell.h"
#import <objc/message.h>
#import "NSString+Addition.h"
#import "RPUtilities.h"

@interface AutoGenSettingVCTL () <UITableViewDataSource,UITableViewDelegate>
{
    
}

@end

@implementation AutoGenSettingVCTL


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
    
    self.title = _autoGen.title;
    
    if (!_tv)
    {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:_autoGen.style];
        _tv.delegate   = self;
        _tv.dataSource = self;
        _tv.backgroundView  = nil;
        _tv.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tv.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tv];
        [self insertTableFooter];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)insertTableFooter
{
    //子类继承
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoGenSection  *genSection  = [_autoGen.sections objectAtIndex:indexPath.section];
    AutoGenCell     *genCell = [genSection.cells objectAtIndex:indexPath.row];
    return genCell.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AutoGenSection *genSection  = [_autoGen.sections objectAtIndex:section];
    AutoGenCellHeader *genHeader  = genSection.header;
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), genHeader.height);
    AutoGenHeaderView *sectionView =  [[NSClassFromString(genHeader.className) alloc] initWithFrame:frame];
    [sectionView setHeader:genHeader];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    AutoGenSection *genSection  = [_autoGen.sections objectAtIndex:section];
    AutoGenCellHeader *genHeader  = genSection.header;
    return genHeader.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoGenSection  *genSection  = [_autoGen.sections objectAtIndex:indexPath.section];
    AutoGenCell     *genCell = [genSection.cells objectAtIndex:indexPath.row];
    
    switch (genCell.actionType) {
        case AutoGenCellType_Link:
        {
            [RPUtilities openUrl:URL(genCell.actionValue)];
        }
            break;
        case AutoGenCellType_Plist:
        {
            if (genCell.actionValue && ![genCell.actionValue isEmpty])
            {
                NSString *path      = [[NSBundle mainBundle] pathForResource:genCell.actionValue ofType:@"plist"];
                NSDictionary *dic   = [[NSDictionary alloc] initWithContentsOfFile:path];
                AutoGen *autoGen    = [[AutoGen alloc] initWithJSONDic:dic];
                AutoGenSettingVCTL *settingVCTL = (AutoGenSettingVCTL*)[[[self class] alloc] init];
                settingVCTL.autoGen = autoGen;
                [self.navigationController pushViewController:settingVCTL animated:YES];
            }
        }
            break;
        case AutoGenCellType_VCTL:
        {
            UIViewController *viewController = [[NSClassFromString(genCell.actionValue) alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case AutoGenCellType_Function:
        {
            SEL selector = NSSelectorFromString(genCell.actionValue);
            if ([self respondsToSelector:selector])
            {
                objc_msgSend(self, selector);
            }
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_autoGen.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AutoGenSection *genSection  = [_autoGen.sections objectAtIndex:section];
    return [genSection.cells count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoGenSection  *genSection  = [_autoGen.sections objectAtIndex:indexPath.section];
    AutoGenCell     *genCell = [genSection.cells objectAtIndex:indexPath.row];
    AutoGenViewCell *cell = (AutoGenViewCell*)[tableView dequeueReusableCellWithIdentifier:genCell.className];
    if (!cell)
    {
        cell = (AutoGenViewCell *)[[NSClassFromString(genCell.className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:genCell.className];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setGenCell:genCell];
    [cell setIndexPath:indexPath];
    
    return cell;
}


@end
