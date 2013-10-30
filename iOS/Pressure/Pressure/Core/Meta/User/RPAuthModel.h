//
//  RPAuthModel.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPSinaModel;
@class RPProfile;
@class RPXmppProfile;

@interface RPAuthModel : RPObject

@property (nonatomic,retain) RPSinaModel *sinaModel;
@property (nonatomic,retain) RPProfile *profile;
@property (nonatomic,retain) RPXmppProfile *xmppProfile;


+ (RPAuthModel *)sharedInstance;
- (BOOL)logined;



@end
