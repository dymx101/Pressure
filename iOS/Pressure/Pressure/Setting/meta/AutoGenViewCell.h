//
//  AutoGenViewCell.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AutoGenCell;

@interface AutoGenViewCell : UITableViewCell




@property (nonatomic,retain) AutoGenCell *genCell;
@property (nonatomic,retain) NSIndexPath *indexPath;

@end
