//
//  AESectionHeaderView.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "RPSectionHeaderView.h"
#import "AutoGenCellHeader.h"
@interface RPSectionHeaderView ()
{
    UILabel *_titleLabel;
}
@end
@implementation RPSectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, frame.size.width, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor       = Default_Deep_Black;
        _titleLabel.font            = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment   = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        UIView *line        = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        line.backgroundColor = Default_Medium_Gray;
        [self addSubview:line];
        
    }
    return self;
}


- (void)setHeader:(AutoGenCellHeader *)header
{
    [super setHeader:header];
    
    _titleLabel.text            = header.title;
}



@end
