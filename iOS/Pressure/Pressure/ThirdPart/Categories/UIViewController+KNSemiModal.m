//
//  KNSemiModalViewController.m
//  KNSemiModalViewController
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

const struct KNSemiModalOptionKeys KNSemiModalOptionKeys = {
	.animationDuration = @"KNSemiModalOptionAnimationDuration",
	.pushParentBack = @"KNSemiModalOptionPushParentBack",
	.parentAlpha = @"KNSemiModalOptionParentAlpha",
	.shadowOpacity = @"KNSemiModalOptionShadowOpacity",
};

static const uint kScreenshotTag = 10;
static const uint kDismissButtonTag = 12;

#define kSemiModalTransitionOptions @"kn_semiModalTransitionOptions"
#define kSemiModalTransitionDefaults @"kn_semiModalTransitionDefaults"

@interface UIViewController (KNSemiModalInternal)
-(UIView*)parentTarget;
-(CAAnimationGroup*)animationGroupForward:(BOOL)_forward delegate:(id)delegate;
@end

@implementation UIViewController (KNSemiModalInternal)

-(UIView*)parentTarget {
  // To make it work with UINav & UITabbar as well
  UIViewController * target = self;
  while (target.parentViewController != nil) {
    target = target.parentViewController;
  }
  return target.view;
}

#pragma mark Options and defaults

-(void)kn_registerTransitionDefaults {
	NSDictionary *defaults = @{
		KNSemiModalOptionKeys.animationDuration : @(0.5),
		KNSemiModalOptionKeys.parentAlpha : @(0.5),
		KNSemiModalOptionKeys.pushParentBack : @(YES),
		KNSemiModalOptionKeys.shadowOpacity : @(0.8),
	};
	objc_setAssociatedObject(self, kSemiModalTransitionDefaults, defaults, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)kn_optionsOrDefaultForKey:(NSString*)optionKey {
	NSDictionary *options = objc_getAssociatedObject(self, kSemiModalTransitionOptions);
	NSDictionary *defaults = objc_getAssociatedObject(self, kSemiModalTransitionDefaults);
	NSAssert(defaults, @"Defaults must have been set when accessing options.");
	return options[optionKey] ?: defaults[optionKey];
}

#pragma mark Push-back animation group

-(CAAnimationGroup*)animationGroupForward:(BOOL)_forward delegate:(id)delegate{
  // Create animation keys, forwards and backwards
  CATransform3D t1 = CATransform3DIdentity;
  t1.m34 = 1.0/-900;
  t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
  t1 = CATransform3DRotate(t1, 15.0f*M_PI/180.0f, 1, 0, 0);

  CATransform3D t2 = CATransform3DIdentity;
  t2.m34 = t1.m34;
  t2 = CATransform3DTranslate(t2, 0, [self parentTarget].frame.size.height*-0.08, 0);
  t2 = CATransform3DScale(t2, 0.8, 0.8, 1);

  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
  animation.toValue = [NSValue valueWithCATransform3D:t1];
	CFTimeInterval duration = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.animationDuration] doubleValue];
  animation.duration = duration/2;
  animation.fillMode = kCAFillModeForwards;
  animation.removedOnCompletion = NO;
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];

  CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
  animation2.toValue = [NSValue valueWithCATransform3D:(_forward?t2:CATransform3DIdentity)];
  animation2.beginTime = animation.duration;
  animation2.duration = animation.duration;
  animation2.fillMode = kCAFillModeForwards;
  animation2.removedOnCompletion = NO;
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
  
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.fillMode = kCAFillModeForwards;
  group.removedOnCompletion = NO;
  group.delegate = delegate;
  [group setDuration:animation.duration*2];
  [group setAnimations:[NSArray arrayWithObjects:animation,animation2, nil]];
  return group;
}
@end

@implementation UIViewController (KNSemiModal)

-(void)presentSemiViewController:(UIViewController*)vc {
	[self presentSemiViewController:vc withOptions:nil];
}

-(void)presentSemiView:(UIView*)view {
	[self presentSemiView:view withOptions:nil];
}

-(void)presentSemiViewController:(UIViewController*)vc withOptions:(NSDictionary*)options {
  [self presentSemiView:vc.view withOptions:options];
}

-(void)presentSemiView:(UIView*)view withOptions:(NSDictionary*)options {
  // Determine target
  UIView * target = [self parentTarget];
	
  if (![target.window.subviews containsObject:view]) {
		// Remember transition options for symmetrical dismiss transition
		objc_setAssociatedObject(self, kSemiModalTransitionOptions, options, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		[self kn_registerTransitionDefaults];
		
    // Calulate all frames
    CGRect sf = view.frame;
    CGRect vf = target.window.frame;
    CGRect f  = CGRectMake(0, vf.size.height-sf.size.height, vf.size.width, sf.size.height);
    CGRect bf = CGRectMake(0, 0, vf.size.width, vf.size.height-sf.size.height);
    CGRect of = CGRectMake(0, 0, vf.size.width, vf.size.height);

    // Add semi overlay
    UIView * overlay = [[UIView alloc] initWithFrame:of];
    overlay.backgroundColor = [UIColor blackColor];
    overlay.alpha = 0.0f;
    overlay.layer.transform = CATransform3DMakeTranslation(0, 0, 200.0f);
    [target.window addSubview:overlay];

    // Dismiss button
    // Don't use UITapGestureRecognizer to avoid complex handling
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton addTarget:self action:@selector(dismissSemiModalView) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = bf;
    dismissButton.tag = kDismissButtonTag;
    [overlay addSubview:dismissButton];

    // Begin overlay animation
		if ([[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.pushParentBack] boolValue]) {
      target.layer.shouldRasterize = YES;
      target.layer.rasterizationScale = [UIScreen mainScreen].scale * 0.8f;
      [target.layer addAnimation:[self animationGroupForward:YES delegate:nil] forKey:@"pushedBackAnimation"];
		}
		NSTimeInterval duration = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.animationDuration] doubleValue];
    [UIView animateWithDuration:duration animations:^{
      overlay.alpha = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.parentAlpha] floatValue];
    }];

    // Present view animated
    view.frame = CGRectMake(0, vf.size.height, vf.size.width, sf.size.height);
    [target.window addSubview:view];
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0, -2);
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOpacity = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.shadowOpacity] floatValue];
    view.layer.transform = CATransform3DMakeTranslation(0, 0,200.0f);
    //view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.shadowPath = path.CGPath;

    [UIView animateWithDuration:duration animations:^{
      view.frame = f;
    } completion:^(BOOL finished) {
      view.layer.shouldRasterize = NO;
      target.layer.shouldRasterize = NO;
      if(finished){
        [[NSNotificationCenter defaultCenter] postNotificationName:kSemiModalDidShowNotification
                                                            object:self];
      }
    }];
  }
}

-(void)dismissSemiModalView {
	[self dismissSemiModalViewWithCompletion:nil];
}

-(void)dismissSemiModalViewWithCompletion:(void (^)(void))completion {
  UIView * target = [self parentTarget];
  UIView * modal = [target.window.subviews objectAtIndex:target.window.subviews.count-1];
  UIView * overlay = [target.window.subviews objectAtIndex:target.window.subviews.count-2];
	NSTimeInterval duration = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.animationDuration] doubleValue];
	[UIView animateWithDuration:duration animations:^{
    modal.frame = CGRectMake(0, target.window.frame.size.height, modal.frame.size.width, modal.frame.size.height);
    overlay.alpha = 0.0f;
  } completion:^(BOOL finished) {
    [overlay removeFromSuperview];
    [modal removeFromSuperview];
    
    if(finished){
      [[NSNotificationCenter defaultCenter] postNotificationName:kSemiModalDidHideNotification
                                                          object:self];
      if (completion) {
        completion();
      }
    }
  }];
  
  // Begin overlay animation
  [target.layer addAnimation:[self animationGroupForward:NO delegate:self] forKey:@"bringForwardAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  
  if (flag){
    self.view.layer.shouldRasterize = NO;
    UIView * target = [self parentTarget];
    target.layer.shouldRasterize = NO;
  }
}

- (void)resizeSemiView:(CGSize)newSize {
  UIView * target = [self parentTarget];
  UIView * modal = [target.window.subviews objectAtIndex:target.window.subviews.count-1];
  CGRect mf = modal.frame;
  mf.size.width = newSize.width;
  mf.size.height = newSize.height;
  mf.origin.y = target.window.frame.size.height - mf.size.height;
  UIView * overlay = [target.window.subviews objectAtIndex:target.window.subviews.count-2];
  UIButton * button = (UIButton*)[overlay viewWithTag:kDismissButtonTag];
  CGRect bf = button.frame;
  bf.size.height = overlay.frame.size.height - newSize.height;
	NSTimeInterval duration = [[self kn_optionsOrDefaultForKey:KNSemiModalOptionKeys.animationDuration] doubleValue];
	[UIView animateWithDuration:duration animations:^{
    modal.frame = mf;
    button.frame = bf;
  } completion:^(BOOL finished) {
    if(finished){
      [[NSNotificationCenter defaultCenter] postNotificationName:kSemiModalWasResizedNotification
                                                          object:self];
    }
  }];
}

@end

#pragma mark - 

// Convenient category method to find actual ViewController that contains a view
// Adapted from: http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone

@implementation UIView (FindUIViewController)
- (UIViewController *) containingViewController {
  
 // UIView * target = self.superview ? self.superview : self;
 // return (UIViewController *)[target traverseResponderChainForUIViewController];
  UIWindow *window = (UIWindow *)self.superview;
  if([window.rootViewController isKindOfClass:[UINavigationController class]]){
    
    UINavigationController *nav = (UINavigationController *)window.rootViewController;
    return [nav.viewControllers lastObject];
  }
  
  return window.rootViewController;
}

- (id) traverseResponderChainForUIViewController {
  id nextResponder = [self nextResponder];
  BOOL isViewController = [nextResponder isKindOfClass:[UIViewController class]];
  BOOL isTabBarController = [nextResponder isKindOfClass:[UITabBarController class]];
  if (isViewController && !isTabBarController) {
    return nextResponder;
  } else if(isTabBarController){
    UITabBarController *tabBarController = nextResponder;
    return [tabBarController selectedViewController];
  } else if ([nextResponder isKindOfClass:[UIView class]]) {
    return [nextResponder traverseResponderChainForUIViewController];
  } else {
    return nil;
  }
}

@end