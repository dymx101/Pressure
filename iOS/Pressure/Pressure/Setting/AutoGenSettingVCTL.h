//
//  AEAutoGenSettingVCTL.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "RPBaseVCTL.h"
@class AutoGen;
@interface AutoGenSettingVCTL : RPBaseVCTL


@property (nonatomic,retain) AutoGen *autoGen;
@property (nonatomic,retain) UITableView *tv;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
