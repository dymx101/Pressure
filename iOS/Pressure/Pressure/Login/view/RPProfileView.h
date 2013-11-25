//
//  RPProfileView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPProfileViewDelegate <NSObject>



@end
@interface RPProfileView : UIView


@property (nonatomic,assign) id<RPProfileViewDelegate> delegate;
@end
