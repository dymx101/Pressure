//
//  RPMessage.h
//  Pressure
//
//  Created by eason on 11/7/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
#define RPMessage_Type @"frChat"
typedef enum _RPMessage_ReadState
{
    RPMessage_ReadState_UnRead = 0,
    RPMessage_ReadState_Readed = 1
}RPMessage_ReadState;

@interface RPMessage : RPObject

@property (nonatomic) long long dbId;
@property (nonatomic) long long userId;
@property (nonatomic) long long toUserId;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *img_url;
@property (nonatomic,copy) NSString *voice_url;
@property (nonatomic) RPMessage_ReadState readed;
@property (nonatomic) NSString *type;


- (BOOL)saveToDB;
+ (NSArray *)messageFromDB:(long long)fromUserId toUserId:(long long)toUserId dbId:(long long)dbId;
+ (NSString *)rpMessageUserIdKey;
+ (NSString *)rpMessageTypeKey;
@end
