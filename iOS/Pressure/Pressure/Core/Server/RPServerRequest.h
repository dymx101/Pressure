//
//  RPServerRequest.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@class RPServerResponse;

#define kRPServerRequest_Header_RefreshToken    @"refreshToken"
#define kRPServerRequest_Header_UserId          @"userId"

#define kRPServerRequest_Body_RequestData       @"requestData"

#define kRPServerRequest_Access_Token           @"access_token"
#define kRPServerRequest_Expire_In              @"expires_in"
#define kRPServerRequest_Uid                    @"uid"
#define kRPServerRequest_Type                   @"type"
#define kRPServerRequest_AgeRange               @"ageRange"
#define kRPServerRequest_Gender                 @"gender"
#define kRPServerRequest_ChatType               @"chatType"
#define kRPServerRequest_City                   @"city"
#define kRPServerRequest_Age                    @"age"
#define kRPServerRequest_NickName               @"nickName"
#define kRPServerRequest_AvatarUrl              @"avatarUrl"
#define kRPServerRequest_Jid                    @"jid"
#define kRPServerRequest_XmppUserName           @"xmppUserName"
#define kRPServerRequest_Limit                  @"limit"
#define kRPServerRequest_BeginTime              @"beginTime"
#define kRPServerRequest_Forum_Text             @"text"
#define kRPServerRequest_UserName               @"userName"
#define kRPServerRequest_PassWord               @"passWord"


@protocol RPServerRequestDelegate <NSObject>

- (void)serverRequestDidSyncCallback:(RPServerResponse *)serverResp;

@end

@interface RPServerRequest : NSObject


//操作类型
@property (nonatomic,copy) NSString *operationType;
//传入参数
@property (nonatomic,retain) NSDictionary *params;
//回调委托
@property (nonatomic,assign) id<RPServerRequestDelegate> target;
//文件数组
@property (nonatomic,retain) NSArray *dataArray;

//请求次数
@property (nonatomic) int requestCount;

@property (nonatomic) int maxRequestCount;

@property (nonatomic,retain) ASIHTTPRequest *asiRequest;

- (NSDictionary *)jsonStrCanPostToServer;

/**
 是否可以再次发送请求，一般一个请求只能发送两次，如果token失效，会再发一次
 @returns 返回
 */
- (BOOL)canRetryToReqServer;

/**
 是否需要token
 @returns yes no
 */
- (BOOL)needToken;



@end
