//
//  RPLoginView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPLoginViewDelegate <NSObject>



@end

@interface RPLoginView : UIView


@property (nonatomic,assign) id<RPLoginViewDelegate> delegate;
@end
