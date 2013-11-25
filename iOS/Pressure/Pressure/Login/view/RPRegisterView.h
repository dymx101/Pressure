//
//  RPRegisterView.h
//  Pressure
//
//  Created by eason on 11/24/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPRegisterViewDelegate <NSObject>



@end
@interface RPRegisterView : UIView


@property (nonatomic,assign) id<RPRegisterViewDelegate> delegate;
@end
