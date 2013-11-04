//
//  RPProfile.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPXmppProfile;
@interface RPProfile : RPObject

@property (nonatomic) long long userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,retain) RPXmppProfile *xmppProfile;

@end
