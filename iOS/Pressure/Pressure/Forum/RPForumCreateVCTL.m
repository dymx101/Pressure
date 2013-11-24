//
//  RPForumCreateVCTL.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPForumCreateVCTL.h"
#import "RPBaseBar.h"
#import "RPBaseVCTL+Server.h"
#import "RPForum.h"
#import "RPAudio.h"
#import "RPPicture.h"
#import "RPAppServerOperation.h"
#import "RPServerApiDef.h"
#define DefaultTextViewHeight 200
@interface RPForumCreateVCTL () <UITextViewDelegate>
{
    UITextView *_textView;
    RPForum    *_forum;
}

@end

@implementation RPForumCreateVCTL

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _forum = [[RPForum alloc] init];
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, CGRectGetWidth(self.contentView.frame) - 40, DefaultTextViewHeight)];
        _textView.font             = [UIFont systemFontOfSize:14];
        _textView.contentInset     = UIEdgeInsetsZero;
        _textView.delegate         = self;
        _textView.backgroundColor  = Default_Low_Gray;
        [self.contentView addSubview:_textView];
        [_textView becomeFirstResponder];
    }
	[self.bar setRightBtnWithText:@"创建"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightButtonClick:(RPBaseBar *)bar
{
    [self serverCallForumCreateNew];
}

- (void)serverCallForumCreateNew
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [_forum.audio proxyForJson], kMetaKey_Audio);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [_forum.picture proxyForJson], kMetaKey_Picture);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_forum.text), @"text");
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(1), @"chat_type");
    [self asynServerCall:kServerApi_Add_To_Forum data:mulDic];
}


- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_Add_To_Forum])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
           [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    _forum.text = _textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}

@end
