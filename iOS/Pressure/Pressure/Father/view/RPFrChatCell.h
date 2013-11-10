//
//  RPFrChatCell.h
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPMessage;
@interface RPFrChatCell : UITableViewCell

- (void)resetCellWithMessage:(RPMessage *)message;
+ (CGFloat)cellHeight:(id)object;
@end
