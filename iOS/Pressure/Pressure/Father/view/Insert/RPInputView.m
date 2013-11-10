//
//  RPInputView.m
//  Pressure
//
//  Created by eason on 11/8/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPInputView.h"
#import "HPGrowingTextView.h"

@interface RPInputView () <HPGrowingTextViewDelegate>
{
    HPGrowingTextView *_textView;
    UIButton *_emojiBtn;
    UIButton *_plusBtn;
}
@end

@implementation RPInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initTextView];
        [self initPlusView];
        
    }
    return self;
}

- (void)initTextView {
    
    _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(17, 4 , 200, 37)];
    _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _textView.returnKeyType= UIReturnKeySend;
    _textView.minNumberOfLines = 1;
    _textView.maxNumberOfLines = 6;
    _textView.font = [UIFont systemFontOfSize:14.0f];
    _textView.delegate = self;
    _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    _textView.textColor= Default_Deep_Black;
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    
    
    UIImage *rawBackground = [UIImage imageNamed:@"bk_session_text_input.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:185/2 topCapHeight:37/2];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = _textView.frame;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:imageView];
    [self addSubview:_textView];
    
    _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emojiBtn.frame = CGRectMake(CGRectGetMaxX(_textView.frame) + 10, 4, 37, 37);
    [_emojiBtn setImage:[UIImage imageNamed:@"btn_session_emot_normal.png"] forState:UIControlStateNormal];
    [_emojiBtn setImage:[UIImage imageNamed:@"btn_session_emot_highlighted.png"] forState:UIControlStateHighlighted];
    [self addSubview:_emojiBtn];
    
    _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _plusBtn.frame = CGRectMake(CGRectGetMaxX(_emojiBtn.frame) + 10, 4, 37, 37);
    [_plusBtn setImage:[UIImage imageNamed:@"btn_session_attachment_normal.png"] forState:UIControlStateNormal];
    [_plusBtn setImage:[UIImage imageNamed:@"btn_session_attachment_highlighted.png"] forState:UIControlStateHighlighted];
    [self addSubview:_plusBtn];
}

- (void)initPlusView
{
    
}


#pragma mark -
#pragma mark HPGrowingTextView Delegate
- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
    
    return YES;
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;

    if ([self.delegate respondsToSelector:@selector(rpInputViewWillChangeHeight)])
    {
        [self.delegate rpInputViewWillChangeHeight];
    }
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{

    if ([self.delegate respondsToSelector:@selector(rpInputViewTextEnd:)])
    {
        [self.delegate rpInputViewTextEnd:growingTextView.text];
        growingTextView.text = @"";
    }
    return YES;
}

- (void)rpInputViewShow
{
    [_textView becomeFirstResponder];
    if (!_showing)
    {
        _showing = YES;
        __block RPInputView *weakView = self;
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = weakView.frame;
            frame.origin.y -= Default_KeyBoardHeight;
            weakView.frame = frame;
            if ([weakView.delegate respondsToSelector:@selector(rpInputViewWillShow)])
            {
                [weakView.delegate rpInputViewWillShow];
            }
        }completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)rpInputViewHide
{
    [_textView resignFirstResponder];
    if (_showing)
    {
        _showing = NO;
        __block RPInputView *weakView = self;
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = weakView.frame;
            frame.origin.y += Default_KeyBoardHeight;
            weakView.frame = frame;
            if ([weakView.delegate respondsToSelector:@selector(rpInputViewWillHide)])
            {
                [weakView.delegate rpInputViewWillHide];
            }
        }completion:^(BOOL finished) {
            
        }];
    }
}
@end
