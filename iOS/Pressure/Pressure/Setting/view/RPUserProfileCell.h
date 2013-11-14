//
//  RPUserProfileCell.h
//  Pressure
//
//  Created by eason on 11/12/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPProfile;
@protocol RPUserProfileCellDelegate <NSObject>

- (void)rpUserProfileCellView1Tap:(NSIndexPath *)indexPath;
- (void)rpUserProfileCellView2Tap:(NSIndexPath *)indexPath;

@end
@interface RPUserProfileCell : UITableViewCell

@property (nonatomic,assign) id<RPUserProfileCellDelegate> delegate;

- (void)resetCellByIndexPath:(NSIndexPath *)indexPath profile:(RPProfile *)profile;


@end
