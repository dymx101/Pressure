//
//  RPAuthModel.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
typedef enum _User_Xmpp_OnlineStatus
{
    User_Xmpp_OnlineStatus_Online,
    User_Xmpp_OnlineStatus_Offline
    
}User_Xmpp_OnlineStatus;

@interface RPAuthModel : RPObject


@property (nonatomic) User_Xmpp_OnlineStatus onlineStatus;


- (id)initWithJSONDic:(NSDictionary *)jsonDic ;
- (void)setWithJSONDic:(NSDictionary *)dic;
- (NSDictionary *)proxyForJson;



@end
