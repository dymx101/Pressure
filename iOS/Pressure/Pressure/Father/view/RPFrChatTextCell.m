//
//  RPFrChatTextcell.m
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFrChatTextCell.h"
#import "RPAuthModel.h"
#import "RPProfile.h"
#import "RPMessage.h"

#define Defualt_Text_Y_Space 7
#define Default_Left_Space 60
#define Default_Avatar_Width 50
#define Default_Origin_Y 10

@interface RPFrChatTextCell ()
{
    UILabel *_textLabel;
    UIButton *_avatarBtn;
    UIImageView *_bgView;
}
@end
@implementation RPFrChatTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _bgView = [[UIImageView alloc] init];
        [self addSubview:_bgView];
        
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.layer.borderWidth = 1.0;
        _avatarBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        _avatarBtn.layer.cornerRadius = 5.0;
        [self addSubview:_avatarBtn];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.backgroundColor = [UIColor clearColor];

        [self addSubview:_textLabel];
        
        
    }
    return self;
}

- (void)resetCellWithMessage:(RPMessage *)message
{
    [super resetCellWithMessage:message];
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    CGSize size = [message.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(RPFrChatTextCell_DefaultTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    _textLabel.text = message.content;
    //如果发消息的人是自己
    if (authModel.profile.userId == message.userId)
    {
        _bgView.frame = CGRectMake(Default_Left_Space + RPFrChatTextCell_DefaultTextWidth - size.width - 20, Default_Origin_Y, size.width + 20, size.height + Defualt_Text_Y_Space * 2);
        _bgView.image  = [[UIImage imageNamed:@"bk_self_sns_normal.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:19];
        _textLabel.frame = CGRectMake(CGRectGetMinX(_bgView.frame) + 10, CGRectGetMinY(_bgView.frame) + Defualt_Text_Y_Space, size.width, size.height);
        _textLabel.textColor = [UIColor whiteColor];
        _avatarBtn.frame = CGRectMake(CGRectGetMaxX(_bgView.frame) + 10, 0, Default_Avatar_Width, Default_Avatar_Width);
        
    }
    else
    {
        _avatarBtn.frame = CGRectMake(10, 0, Default_Avatar_Width, Default_Avatar_Width);
        _bgView.frame = CGRectMake(CGRectGetMaxX(_avatarBtn.frame) + 10, Default_Origin_Y, size.width + 20, size.height + Defualt_Text_Y_Space *2);
        _textLabel.frame = CGRectMake(CGRectGetMinX(_bgView.frame) + 10, CGRectGetMinY(_bgView.frame) +  Defualt_Text_Y_Space, size.width, size.height);
        _textLabel.textColor = [UIColor blackColor];
        _bgView.image = [[UIImage imageNamed:@"bk_other_message_normal.png"] stretchableImageWithLeftCapWidth:25 topCapHeight:19];
        
    }
}


+ (CGFloat)cellHeight:(id)object
{
    NSString *text = (NSString *)object;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(RPFrChatTextCell_DefaultTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height + 20 + Default_Origin_Y *2;
}


@end
