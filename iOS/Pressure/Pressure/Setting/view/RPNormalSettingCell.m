//
//  AENormalSettingCell.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "RPNormalSettingCell.h"
#import "AutoGenCell.h"
@interface RPNormalSettingCell ()
{
    UILabel *_titleLabel;
    
}
@end

@implementation RPNormalSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView  = [[UIView alloc] init];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor       = Default_Deep_Black;
        _titleLabel.font            = [UIFont systemFontOfSize:14];
        _titleLabel.center          = CGPointMake(_titleLabel.center.x, self.frame.size.height/2);
        _titleLabel.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        UIView * accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 15)];
        accessoryView.layer.contents = (id)[UIImage imageNamed:@"TradeManager.bundle/atm_jiantou.png"].CGImage;
        self.accessoryView =  accessoryView;

    }
    return self;
}

- (void)setGenCell:(AutoGenCell *)genCell
{
    [super setGenCell:genCell];
    _titleLabel.text = genCell.title;
    
}


@end
