//
//  RPPlusView.m
//  Pressure
//
//  Created by eason on 11/10/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPPlusView.h"
@interface RPPlusView ()
{
    UIButton *_takePhotoBtn;
    UIButton *_selectPhotoBtn;
}
@end
@implementation RPPlusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        _takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [_takePhotoBtn setTitle:@"拍照" forState:UIControlStateHighlighted];
        _takePhotoBtn.frame = CGRectMake(10, 10, 50, 50);
        [_takePhotoBtn addTarget:self action:@selector(takePhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_takePhotoBtn];
        
        
        _selectPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectPhotoBtn setTitle:@"相册" forState:UIControlStateNormal];
        [_selectPhotoBtn setTitle:@"相册" forState:UIControlStateHighlighted];
        [_selectPhotoBtn addTarget:self action:@selector(selectPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)takePhotoBtnClick:(id)sender
{
    
}

- (void)selectPhotoBtnClick:(id)sender
{
    
}

@end
