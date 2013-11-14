//
//  RPUserProfileCell.m
//  Pressure
//
//  Created by eason on 11/12/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPUserProfileCell.h"
#import "RPProfile.h"
@interface RPUserProfileCell ()
{
    UIView  *_view1;
    UIView  *_view2;
    UILabel *_label1;
    UILabel *_label1Count;
    UILabel *_label2;
    UILabel *_label2Count;
    NSIndexPath *_indexPath;

}

@end
@implementation RPUserProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _view1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
        _view2  = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 44)];
        _view1.userInteractionEnabled = YES;
        _view2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1TapGesture:)];
        [_view1 addGestureRecognizer:tapGesture1];
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view2TapGesture:)];
        [_view2 addGestureRecognizer:tapGesture2];
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 20)];
        _label1Count = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 20, 20)];
        [_view1 addSubview:_label1];
        [_view1 addSubview:_label1Count];
        
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 20)];
        _label2Count = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 20, 20)];
        [_view2 addSubview:_label2];
        [_view2 addSubview:_label2Count];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)resetCellByIndexPath:(NSIndexPath *)indexPath profile:(RPProfile *)profile
{
    _indexPath = indexPath;
    if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            _label1.text = @"性别";
            _label1Count.text = profile.gender == RPProfile_Gender_Male ? @"男":@"女";
            _label2.text = @"城市";
            _label2Count.text = @"杭州";
        }
    }else if (indexPath.section == 2)
    {
        _label1.text = @"我的积分";
        _label2.text = @"我的金币";
    }else if (indexPath.section == 3)
    {
        _label1.text = @"我的日记本";
        _label2.text = @"我的神父们";
    }
}


- (void)view1TapGesture:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(rpUserProfileCellView1Tap:)])
    {
        [self.delegate rpUserProfileCellView1Tap:_indexPath];
    }
}

- (void)view2TapGesture:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(rpUserProfileCellView2Tap:)])
    {
        [self.delegate rpUserProfileCellView2Tap:_indexPath];
    }
}
@end
