//
//  RPXmppProfile.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"

typedef enum _User_Xmpp_OnlineStatus
{
    User_Xmpp_OnlineStatus_Online,
    User_Xmpp_OnlineStatus_Offline
    
}User_Xmpp_OnlineStatus;

@interface RPXmppProfile : RPObject

@property (nonatomic,copy) NSString *xmppUserName;
@property (nonatomic) User_Xmpp_OnlineStatus onlineStatus;
@property (nonatomic,copy) NSString *secretKey;
@property (nonatomic,copy) NSString *domain;

- (NSString *)fullUserName;
- (NSString *)password;
@end
