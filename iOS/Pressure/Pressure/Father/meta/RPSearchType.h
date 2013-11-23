//
//  RPSearchType.h
//  Pressure
//
//  Created by eason on 11/17/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
#import "RPProfile.h"
@class RPChatType;
@interface RPSearchType : RPObject

@property (nonatomic,copy) NSString *ageRange;
@property (nonatomic) RPProfile_Gender gender;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,retain) RPChatType *chatType;

@end
