//
//  RPUserProfileVCTL.m
//  Pressure
//
//  Created by eason on 11/12/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPUserProfileVCTL.h"
#import "RPUserProfileCell.h"
#import "RPUserProfileHeaderView.h"
#import "RPProfile.h"
#import "RPAuthModel.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "BlockActionSheet.h"
#import "RPQiNiuUtil.h"
#import "QiniuSimpleUploader.h"
@interface RPUserProfileVCTL () <UITableViewDelegate,UITableViewDataSource,RPUserProfileCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QiniuUploadDelegate>
{
    UITableView *_tv;
    RPUserProfileHeaderView *_headerView;
    RPProfile *_profile;
    UIScrollView *_imageScrollView;
    QiniuSimpleUploader *_uploader;
}

@end

@implementation RPUserProfileVCTL

- (id)initWithProfile:(RPProfile *)profile
{
    self = [super init];
    if (self)
    {
        _profile = profile;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_imageScrollView)
    {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _imageScrollView.backgroundColor                  = [UIColor clearColor];
        _imageScrollView.showsHorizontalScrollIndicator   = NO;
        _imageScrollView.showsVerticalScrollIndicator     = NO;
        [self.contentView addSubview:_imageScrollView];
    }
    
    if (!_tv)
    {
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.backgroundView = nil;
        _tv.backgroundColor = [UIColor clearColor];
        _tv.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tv.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_tv];
    }
    
    if (!_headerView)
    {
        _profile.avatarUrl = @"http://img1.ph.126.net/1OFZmeDpFo76P0vErXvptQ==/6598248443123074819.jpg";
        _headerView = [[RPUserProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, RPUserProfileHeaderView_Origin_Height) profile:_profile];
        [_imageScrollView addSubview:_headerView];
        
    }
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutImage];
    [self updateOffsets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parallax effect

- (void)updateOffsets
{
    CGFloat yOffset   = _tv.contentOffset.y;
    CGFloat threshold = RPUserProfileHeaderView_Max_Height - RPUserProfileHeaderView_Origin_Height;
    
    if (yOffset > -threshold && yOffset < 0) {
        _imageScrollView.contentOffset = CGPointMake(0.0, floorf(yOffset / 2.0));
    } else if (yOffset < 0) {
        _imageScrollView.contentOffset = CGPointMake(0.0, yOffset + floorf(threshold / 2.0));
    } else {
        _imageScrollView.contentOffset = CGPointMake(0.0, yOffset);
    }
}

- (void)layoutImage
{
    CGFloat imageYOffset = floorf((RPUserProfileHeaderView_Origin_Height  - RPUserProfileHeaderView_Max_Height) / 2.0);
    CGFloat imageXOffset = 0.0;
    
    _headerView.frame             = CGRectMake(imageXOffset, imageYOffset, SCREEN_WIDTH, RPUserProfileHeaderView_Max_Height);
    _imageScrollView.contentSize   = CGSizeMake(SCREEN_WIDTH, self.contentView.bounds.size.height);
    _imageScrollView.contentOffset = CGPointMake(0.0, 0.0);
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return RPUserProfileHeaderView_Origin_Height;
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 44;
    }
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        __block RPUserProfileVCTL *weakSelf = self;
        BlockActionSheet *sheet = [[BlockActionSheet alloc] initWithTitle:@"上传头像"];
        [sheet addButtonWithTitle:@"拍照" block:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = weakSelf;
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }];
        [sheet addButtonWithTitle:@"从手机相册选择" block:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = weakSelf;
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }];
        [sheet setCancelButtonWithTitle:@"下次再传" block:nil];
        [sheet showInView:self.view];
    }else if (indexPath.section == 1)
    {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }else if (section == 2)
    {
        return 1;
    }else if (section == 3)
    {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RPUserProfileHeaderView_Max_Height"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RPUserProfileHeaderView_Max_Height"];
            cell.backgroundColor             = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle              = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
            cell.backgroundColor  = [UIColor redColor];
            UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
            introductionLabel.text = @"我是一个傻逼傻逼傻逼";
            introductionLabel.backgroundColor  =[UIColor redColor];
            [cell addSubview:introductionLabel];
        }
        return cell;
    }else
    {
        RPUserProfileCell *profileCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RPUserProfileCell class])];
        if (!profileCell)
        {
            profileCell = [[RPUserProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([RPUserProfileCell class])];
            profileCell.delegate = self;
        }
        [profileCell resetCellByIndexPath:indexPath profile:_profile];
        return profileCell;
    }
}

#pragma mark - Table View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateOffsets];
}


#pragma mark -
#pragma mark RPUserProfileCell Delegate
- (void)rpUserProfileCellView1Tap:(NSIndexPath *)indexPath
{
    
}

- (void)rpUserProfileCellView2Tap:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd-HH-mm-ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *timeDesc = [formatter stringFromDate:[NSDate date]];

    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage] || [mediaType isEqualToString:(NSString *)ALAssetTypePhoto]) {
        
        NSString *key = [NSString stringWithFormat:@"%@%@", timeDesc, @".jpg"];
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:key];
        NSLog(@"Upload Path: %@", filePath);
        
        NSData *webData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1);
        [webData writeToFile:filePath atomically:YES];
   
        NSFileManager *manager = [NSFileManager defaultManager];
        
        if ([manager fileExistsAtPath:filePath]) {
            
            _uploader= [QiniuSimpleUploader uploaderWithToken:[RPQiNiuUtil token]];
            _uploader.delegate = self;
            [_uploader uploadFile:filePath key:key extra:nil];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark QiniuSimpleUploader Delegate
- (void)uploadSucceeded:(NSString *)filePath ret:(NSDictionary *)ret
{
    
}

- (void)uploadFailed:(NSString *)filePath error:(NSError *)error
{
    
}
@end
