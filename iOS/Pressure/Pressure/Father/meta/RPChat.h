//
//  RPChat.h
//  Pressure
//
//  Created by eason on 11/22/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPProfile;
typedef enum _RPChat_UserType
{
    RPChat_UserType_Talker,
    RPChat_UserType_Father
}RPChat_UserType;
@interface RPChat : RPObject

@property (nonatomic,retain) RPProfile *profile;
@property (nonatomic) int unreadCount;
@property (nonatomic) RPChat_UserType userType;
@property (nonatomic) long long chat_id;

@end
