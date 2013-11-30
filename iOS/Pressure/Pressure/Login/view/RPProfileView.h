//
//  RPProfileView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPProfile;

@protocol RPProfileViewDelegate <NSObject>

- (void)rpProfileViewDidSelect:(RPProfile *)profile;

@end
@interface RPProfileView : UIView


@property (nonatomic,assign) id<RPProfileViewDelegate> delegate;
@end
