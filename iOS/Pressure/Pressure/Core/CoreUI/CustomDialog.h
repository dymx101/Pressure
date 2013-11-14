//
//  CustomDialog.h
//  MyBabyCare
//
//  Created by Tom on 10/13/11.
//  Copyright 2011 儒果科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDialogDelegate;

@interface CustomDialog : UIView {

  UIView *_backgroundView;
  UIImageView *_imageView;
  UIButton *_okButton;
  UIButton *_cancelButton;
  id <CustomDialogDelegate> _delegate;
}

/**
 * Subclasses may override to perform actions just prior to showing the dialog.
 */
- (void)dialogWillAppear;

/**
 * Subclasses may override to perform actions just after the dialog is hidden.
 */
- (void)dialogWillDisappear;


/**
 *
 * Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 */
- (void)dialogDidSucceed;

/**
 *
 * Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 */

- (void)dialogDidCancel;

- (void)dismiss:(BOOL)animated ;

- (void)show;

- (id)initWithFrame:(CGRect)frame
           delegate:(id <CustomDialogDelegate>)aDelegate
       imageNameStr:(NSString *)imageNameStr
         okBtnFrame:(CGRect)okBtnFrame
  okBtnImageNameStr:(NSString *)okBtnImageNameStr
       cancelBtnFrame:(CGRect)cancelBtnFrame
cancelBtnImageNameStr:(NSString *)cancelBtnImageNameStr;

@end


/*
 *Your application should implement this delegate
 */
@protocol CustomDialogDelegate <NSObject>

@optional

/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
- (void)dialogDidComplete:(CustomDialog *)dialog;

/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
- (void)dialogDidNotComplete:(CustomDialog *)dialog;

/**
 * Called when dialog failed to load due to an error.
 */
- (void)dialog:(CustomDialog *)dialog didFailWithError:(NSError *)error;

@end
