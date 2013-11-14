//
//  RPFrChatBar.h
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RPFrChatBar_Height 50
@protocol RPFrChatBarDelegate <NSObject>

- (void)rpFrChatBarFatherBtnClick;
- (void)rpFrChatBarTalkerBtnClick;

@end
@interface RPFrChatBar : UIView


@property (nonatomic,assign) id<RPFrChatBarDelegate> delegate;
@end
