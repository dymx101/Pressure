//
//  RPLoginView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPUtilities.h"
@class RPLoginView;
@protocol RPLoginViewDelegate <NSObject>

- (void)rpLoginViewLogin:(NSString*)userName passWord:(NSString *)passWord;

@end
@interface RPLoginView : UIView

@property (nonatomic,copy) VoidBlockType registerBlock;
@property (nonatomic,assign) id<RPLoginViewDelegate> delegate;

@end
