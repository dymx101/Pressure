//
//  RPServerResponse.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPObject.h"
typedef enum _RPServerResponseCode

{
    
    RPServerResponseCode_Succ       = 1,
    RPServerResponseCode_Failed     =  -1,
    RPServerResponseCode_UserNoFound = -10,
    RPServerResponseCode_ParamNotFound = -11,
    RPServerResponseCode_TokenNotFound = -100,
    RPServerResponseCode_TokenIsInvalid   =  -101
    
} RPServerResponseCode;

typedef enum _ServerResponseLocalStatus
{
    ServerResponseLocalStatus_Succ =0,
    ServerResponseLocalStatus_Failed = 1,
    //网络连接错误
    ServerResponseLocalStatus_NetWork_Failed = 2,
    //请求不匹配
    ServerResponseLocalStatus_Request_Not_Match = 3,
    //请求超时
    ServerResponseLocalStatus_Time_Out = 4,
    //请求被取消
    ServerResponseLocalStatus_Canceled = 5,
} ServerResponseLocalStatus;
@interface RPServerResponse : RPObject


@property (nonatomic,retain) NSDictionary *obj;
@property (nonatomic) RPServerResponseCode code;
@property (nonatomic,copy) NSString *operationType;


@property (nonatomic) ServerResponseLocalStatus localStatus;



@end
