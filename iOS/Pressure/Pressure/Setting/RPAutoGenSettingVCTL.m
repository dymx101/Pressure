//
//  AEAutoGenSettingVCTL.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-23.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "RPAutoGenSettingVCTL.h"
#import "AutoGenViewCell.h"
#import "AutoGen.h"
#import "AutoGenCell.h"
#import "RPNormalSettingCell.h"
#import "AutoGenCell.h"



@interface RPAutoGenSettingVCTL ()
{

}

@end

@implementation RPAutoGenSettingVCTL

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
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
    
}

#pragma mark -
#pragma mark UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoGenViewCell *cell = (AutoGenViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
