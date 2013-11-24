//
//  RPForumCell.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPForumCell.h"
#import "RPProfile.h"
#import "RPForum.h"
#define Default_Label_Width 280
#define Default_Left_Space 20
#define Default_Label_Font [UIFont systemFontOfSize:12]
#define Default_Label_Max_Height 60
@interface RPForumCell ()
{
    UILabel *_textLabel;
    UILabel *_nameLabel;
    UIButton *_helpBtn;
    int _index;
    
}
@end
@implementation RPForumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = Default_Label_Font;
        _textLabel.textColor = Default_Deep_Black;
        [self addSubview:_textLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Default_Left_Space, CGRectGetMaxY(_textLabel.frame) + 10, Default_Label_Width, 20)];
        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_nameLabel];
        
        _helpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _helpBtn.frame = CGRectMake(0, 0, 20, 20);
        [_helpBtn setTitle:@"帮助你" forState:UIControlStateNormal];
        [_helpBtn setTitle:@"帮助你" forState:UIControlStateHighlighted];
        [_helpBtn addTarget:self action:@selector(helpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_helpBtn];
    }
    return self;
}

- (void)resetCell:(RPForum *)forum index:(int)index
{
    _index = index;
    RPProfile *profile = forum.profile;
    _nameLabel.text = profile.nickName;
    
    CGSize size = [forum.text sizeWithFont:Default_Label_Font constrainedToSize:CGSizeMake(Default_Label_Width, Default_Label_Max_Height) lineBreakMode:NSLineBreakByWordWrapping];
    _textLabel.frame = CGRectMake(Default_Left_Space, 10, Default_Label_Width, size.height);
    _textLabel.text = forum.text;
}


- (void)helpBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(rpForumCellHelpBtnClick:)])
    {
        [self.delegate rpForumCellHelpBtnClick:_index];
    }
}

+ (CGFloat)cellHeight:(RPForum *)forum
{
    CGSize size = [forum.text sizeWithFont:Default_Label_Font constrainedToSize:CGSizeMake(Default_Label_Width, Default_Label_Max_Height) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + 80;
}
@end
