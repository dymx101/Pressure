//
//  RPForumCell.h
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPForum;

@protocol RPForumCellDelegate <NSObject>

- (void)rpForumCellHelpBtnClick:(int)index;

@end
@interface RPForumCell : UITableViewCell


@property (nonatomic,assign) id<RPForumCellDelegate> delegate;
- (void)resetCell:(RPForum *)forum index:(int)index;

+ (CGFloat)cellHeight:(RPForum *)forum;
@end
