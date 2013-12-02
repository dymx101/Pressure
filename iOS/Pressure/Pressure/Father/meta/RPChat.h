//
//  RPChat.h
//  Pressure
//
//  Created by eason on 11/22/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPProfile;
typedef enum _RPChat_VisitUserType
{
    RPChat_VisitUserType_None = -1,
    RPChat_VisitUserType_Talker = 0,
    RPChat_VisitUserType_Father = 1
}RPChat_VisitUserType;
@interface RPChat : RPObject

@property (nonatomic,retain) RPProfile *profile;
@property (nonatomic) int unreadCount;
@property (nonatomic) RPChat_VisitUserType userType;
@property (nonatomic) long long chat_id;
@property (nonatomic) long long update_time;

@end
