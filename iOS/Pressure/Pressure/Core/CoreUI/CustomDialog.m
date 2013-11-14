//
//  CustomDialog.m
//
//
//  Created by Tom on 10/13/11.
//  Copyright 2011 . All rights reserved.
//

#import "CustomDialog.h"
#import "RPUtilities.h"
#define kTransitionDuration    0.3

@implementation CustomDialog

#pragma mark -
#pragma mark Private

- (void)initialDelayEnded {

  self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/ 1.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
  self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
  [UIView commitAnimations];
}

- (void)bounce1AnimationStopped {

  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/ 2];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
  self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
  [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {

  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kTransitionDuration/ 2];
  self.transform = CGAffineTransformIdentity;
  [UIView commitAnimations];
}

- (void)postDismissCleanup {

  [RPUtilities runOnMainQueueWithoutDeadlocking:^{
    [_backgroundView removeFromSuperview];
    [self removeFromSuperview];
  }];

  
}

- (void)dismiss:(BOOL)animated {

  [self dialogWillDisappear];

  if (animated) {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(postDismissCleanup)];
    self.alpha = 0;
    [UIView commitAnimations];
  } else {
    [self postDismissCleanup];
  }
}

- (void)cancelButtonPressed {

  [self dialogDidCancel];
}

- (void)okButtonPressed {

  [self dialogDidSucceed];
}

- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated {

  if (success) {
    if ([_delegate respondsToSelector:@selector(dialogDidComplete:)]) {
      [_delegate dialogDidComplete:self];
    }
  } else {
    if ([_delegate respondsToSelector:@selector(dialogDidNotComplete:)]) {
      [_delegate dialogDidNotComplete:self];
    }
  }

  [self dismiss:animated];
}

- (void)dismissWithError:(NSError *)error animated:(BOOL)animated {

  if ([_delegate respondsToSelector:@selector(dialog:didFailWithError:)]) {
    [_delegate dialog:self didFailWithError:error];
  }

  [self dismiss:animated];
}

#pragma mark -
#pragma mark Public

- (id)initWithFrame:(CGRect)frame {
  
  self=[super initWithFrame:frame];
  if(self){
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    
    self.backgroundColor = [UIColor clearColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
           delegate:(id <CustomDialogDelegate>)aDelegate
       imageNameStr:(NSString *)imageNameStr
         okBtnFrame:(CGRect)okBtnFrame
  okBtnImageNameStr:(NSString *)okBtnImageNameStr
       cancelBtnFrame:(CGRect)cancelBtnFrame
cancelBtnImageNameStr:(NSString *)cancelBtnImageNameStr {

  self = [self initWithFrame:frame];
  if (self) {
    // Initialization code
    _delegate = aDelegate;


    // 设置imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
      _imageView.image = [UIImage imageNamed:imageNameStr];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_imageView];


    // 设置ok按钮
      UIImage *buttonImage = [UIImage imageNamed:okBtnImageNameStr];
    _okButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [_okButton setImage:buttonImage forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(okButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    _okButton.showsTouchWhenHighlighted = YES;
    _okButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleBottomMargin;
    [_okButton setFrame:okBtnFrame];
    [self addSubview:_okButton];

    // 设置cancel 按钮, cancel按钮是不一定需要的
    if (cancelBtnImageNameStr) {

        buttonImage = [UIImage imageNamed:cancelBtnImageNameStr];
      _cancelButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
      [_cancelButton setImage:buttonImage forState:UIControlStateNormal];
      [_cancelButton addTarget:self action:@selector(cancelButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
      _cancelButton.showsTouchWhenHighlighted = YES;
      _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
          | UIViewAutoresizingFlexibleBottomMargin;
      [_cancelButton setFrame:cancelBtnFrame];
      [self addSubview:_cancelButton];
    
    }
  }
  return self;
}

- (void)dealloc {

  [_imageView release];
  [_okButton release];
  [_cancelButton release];
  [_backgroundView release];

  [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dialogWillAppear {
}

- (void)dialogWillDisappear {
}

- (void)dialogDidSucceed {

  [self dismissWithSuccess:YES animated:YES];
}

- (void)dialogDidCancel {

  [self dismissWithSuccess:NO animated:YES];
}


- (void)show {

  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  if (!window) {
    window = [[UIApplication sharedApplication].windows objectAtIndex:0];
  }

  _backgroundView.frame = window.frame;
  [_backgroundView addSubview:self];
  [window addSubview:_backgroundView];

  [self dialogWillAppear];
  [self initialDelayEnded];
}

@end
