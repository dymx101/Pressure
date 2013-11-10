//
//  RPFrChatCell.m
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatCell.h"
#import "RPMessage.h"
@implementation RPFrChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetCellWithMessage:(RPMessage *)message
{
    
}

+ (CGFloat)cellHeight:(id)object
{
    return 0;
}
@end
