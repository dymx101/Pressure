//
//  RPRegisterView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPUtilities.h"

@protocol RPRegisterViewDelegate <NSObject>

- (void)rpRegisterViewRegister:(NSString *)userName pass:(NSString *)pass;

@end
@interface RPRegisterView : UIView



@property (nonatomic,assign) id<RPRegisterViewDelegate> delegate;
@property (nonatomic,copy) VoidBlockType cancelBlock;
@end
