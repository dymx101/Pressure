//
//  RPServerOperation.m
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPServerOperation.h"
#import "RPServerRequest.h"
#import "RPServerApiDef.h"
#import "ASIFormDataRequest.h"
#import "RPUtilities.h"
#import "RPServerResponse.h"
#import "RPSession.h"
#import "RPProfile.h"
#import "Reachability.h"
#import "JSON20.h"
#import "RPAppServerOperation.h"
#import "RPAuthModel.h"

#define kAsync_ServerRequest @"Async_ServerRequest"
@interface RPServerOperation ()
{
        NSMutableArray *_requestArray;
}
@end
@implementation RPServerOperation


+ (RPServerOperation *) sharedInstance
{
    
    static dispatch_once_t  onceToken;
    static RPServerOperation *operation;
    dispatch_once(&onceToken, ^{
        
        operation = [[RPServerOperation alloc] init];
        operation.networking = YES;
    });
    return operation;
}


/**
 重新发送一次请求
 @param serverReq
 @param error
 */
- (void)requestAgain:(RPServerRequest *)serverReq error:(NSError *)error
{
    serverReq.requestCount ++;
    [self syncToServerByRequest:serverReq];
}


- (RPServerRequest *)generateDefaultServerRequest:(id)target
                                  operationType:(NSString *)operationType
                                            dic:(NSDictionary *)dic
{
    RPServerRequest *serverReq = [[RPServerRequest alloc] init];
    serverReq.operationType  = operationType;
    if (dic)
    {
        serverReq.params     = dic;
    }else
    {
        serverReq.params = [NSMutableDictionary dictionary];
    }
    
    serverReq.dataArray      = nil;
    serverReq.target         = target;
    
    @synchronized(_requestArray)
    {
        if (!_requestArray)
        {
            _requestArray = [[NSMutableArray alloc] init];
        }
        [_requestArray addObject:serverReq];
    }
    return serverReq;
}

/**
 删除所有与target相关的请求
 @param target
 */
- (void)removeRequestTarget:(id)target
{
    
    @synchronized(_requestArray)
    {
        NSMutableArray *indexArray = [[NSMutableArray alloc] init];
        int index = 0;
        for (RPServerRequest *serverReq in _requestArray)
        {
            if (serverReq.target == target)
            {
                [indexArray addObject:[NSNumber numberWithInt:index]];
                serverReq.target = nil;
                if (serverReq.asiRequest)
                {
                    //如果请求删掉，http请求取消
                    [serverReq.asiRequest cancel];
                }
                serverReq.asiRequest = nil;
            }
            index ++;
        }
        if ([indexArray count] > 0)
        {
            for (int i = [indexArray count] - 1 ;i >= 0;i--)
            {
                NSNumber *indexNum = [indexArray objectAtIndex:i];
                
                [_requestArray removeObjectAtIndex:[indexNum intValue]];
            }
        }
        
    }
}

/**
 请求结束后删除单个请求
 @param serverReq
 */
- (void)removeSingleRequest:(RPServerRequest *)serverReq

{
    @synchronized(_requestArray)
    {
        int index = 0;
        BOOL succ = NO;
        for (RPServerRequest *request in _requestArray)
        {
            if (serverReq == request)
            {
                succ = YES;
                break;
            }
            index ++;
        }
        if (succ)
        {
            [_requestArray removeObjectAtIndex:index];
        }
        
    }
}



/**
 同步连接服务器
 @param serverRequest 请求
 */
- (void)syncToServerByRequest:(RPServerRequest *)serverRequest
{
    ASIFormDataRequest *request = [self sendURL:serverRequest isSync:YES];
    if (request)
    {
        [self responseFromReq:request serverReq:serverRequest];
    }
    
}

/**
 异步连接服务器
 @param serverRequest 请求
 */
- (void)asyncToServerByRequest:(RPServerRequest *)serverRequest
{
    [self sendURL:serverRequest isSync:NO];
}


- (ASIFormDataRequest *)sendURL:(RPServerRequest *)serverRequest isSync:(BOOL)isSync
{
    if (![self checkNetWork])
    {
        RPServerResponse *response = [[RPServerResponse alloc] init];
        response.localStatus = ServerResponseLocalStatus_NetWork_Failed;
        response.operationType = serverRequest.operationType;
        [self finishedRequest:serverRequest serverResp:response];
        return nil;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/%@/",[RPServerOperation host],serverRequest.operationType];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:URL(urlStr)];
    
    [self insertDefaultRequestParam:request];
    
    serverRequest.asiRequest = request;
    
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    //如果token失效，并且请求需要登录以后才能操作，并且不是刷新token的请求。那么，刷新一次token
    if (![authModel serverLogined] && [serverRequest needToken] && ![serverRequest.operationType isEqualToString:kServerApi_RefreshToken])
    {
        [[RPAppServerOperation sharedRPAppServerOperation] serverCallRefreshToken];
    }
    
    //如果正在刷新token，将请求放入刷token接口中等待完成后继续
    if ([[RPAppServerOperation sharedRPAppServerOperation] refreshingToken] && ![serverRequest.operationType isEqualToString:kServerApi_RefreshToken])
    {
        [[RPAppServerOperation sharedRPAppServerOperation] serverCallRefreshToken];
    }
    
    [request addRequestHeader:kRPServerRequest_Header_RefreshToken value:SAFESTR([RPAuthModel sharedInstance].session.refreshToken)];
    [request addRequestHeader:kRPServerRequest_Header_UserId value:LONGLONG2STR([RPAuthModel sharedInstance].profile.userId)];
    
    [request setRequestMethod:@"POST"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[serverRequest jsonStrCanPostToServer],kRPServerRequest_Body_RequestData, nil];
    NSData *data = [[dic JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:data];
    
    MLOG(@"/**************** param data: %@ *******************/", [serverRequest jsonStrCanPostToServer]);
    
    if (serverRequest.dataArray != nil) {
        
        for (id dic in serverRequest.dataArray)
        {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                //传文件
            }
        }
    }
    
    if (isSync)
    {
        [request startSynchronous];
    }else
    {
        [request setUserInfo:@{kAsync_ServerRequest:serverRequest}];
        request.delegate = self;
        [request startAsynchronous];
    }
    
    
    return request;
}



/**
 设置请求的一些默认参数
 @param request
 */
- (void)insertDefaultRequestParam:(ASIHTTPRequest *)request
{
    [request setTimeOutSeconds:30];
    
    [request setValidatesSecureCertificate:NO];
    [request setNumberOfTimesToRetryOnTimeout:1];
    
}



- (void)finishedRequest:(RPServerRequest *)serverReq serverResp:(RPServerResponse *)serverResp
{
    
    [RPUtilities runOnMainQueueWithoutDeadlocking:^{
        if (serverReq && serverResp && [serverReq.target respondsToSelector:@selector(serverRequestDidSyncCallback:)])
        {
            [serverReq.target serverRequestDidSyncCallback:serverResp];
        }
    }];
    
    [self removeSingleRequest:serverReq];
}


#pragma mark -
#pragma mark ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
    
    MLOG(@"/******** requestFinish ********/");
    RPServerRequest *serverReq = [request userInfo][kAsync_ServerRequest];
    [[RPServerOperation sharedInstance] responseFromReq:request serverReq:serverReq];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
    MLOG(@"/*******  requestFialed *******/");
    RPServerRequest *serverReq   = [request userInfo][kAsync_ServerRequest];
    [[RPServerOperation sharedInstance] responseFromReq:request serverReq:serverReq];
}

/**
 获取返回的服务器请求数据，并做回调操作
 @param request 请求
 @param serverReq 项目相关请求
 @returns 返回是否成功
 */
- (BOOL)responseFromReq:(ASIHTTPRequest *)request serverReq:(RPServerRequest *)serverReq
{
    if (request == nil)
    {
        RPServerResponse *response = [[RPServerResponse alloc] init];
        response.localStatus = ServerResponseLocalStatus_Failed;
        response.operationType = serverReq.operationType;
        [self finishedRequest:serverReq serverResp:response];
        return NO;
    }
    
    NSError *error = [request error];
    if (error)
    {
        [self dealAsiHttpRequestError:error serverReq:serverReq request:request];
        return NO;
    }
    
    MLOG(@"/**************** server return: %@ *******************/", request.responseString);
    
    
    RPServerResponse *response = [self respObjFromRequest:request serverReq:serverReq];
    /**
     token失效。拿长效token去刷一次，获取短效token
     **/
    switch (response.code) {
        case RPServerResponseCode_TokenIsInvalid:
        {
            //达到最大请求次数，返回错误内容
            if ([serverReq canRetryToReqServer])
            {
                //刷新token，请求数增加一次，同步再进行一次调用
                [[RPAppServerOperation sharedRPAppServerOperation] serverCallRefreshToken];
                [self requestAgain:serverReq error:nil];
                return NO;
            }
        }
        default:
            break;
    }
    
    [self finishedRequest:serverReq serverResp:response];
    
    return YES;
}


/**
 处理http的一些错误，与应用服务器无关
 @param error
 @param serverReq
 @param request
 */
- (void)dealAsiHttpRequestError:(NSError *)error
                      serverReq:(RPServerRequest*)serverReq
                        request:(ASIHTTPRequest *)request

{
    MLOG(@"/**************** responseFromReq: %@ *******************/",error);
    RPServerResponse *response = [[RPServerResponse alloc] init];
    response.operationType = serverReq.operationType;
    switch (error.code) {
        case ASIRequestCancelledErrorType:
        {
            response.localStatus = ServerResponseLocalStatus_Canceled;
        }
            break;
        case ASIRequestTimedOutErrorType:
        {
            response.localStatus = ServerResponseLocalStatus_Time_Out;
        }
        default:
        {
            if ([serverReq canRetryToReqServer]&&_networking)
            {
                [self requestAgain:serverReq error:error];
                return ;
            }else
            {
                response.localStatus = ServerResponseLocalStatus_Failed;
            }
        }
            break;
    }
    [self finishedRequest:serverReq serverResp:response];
    return ;
}


- (RPServerResponse *)respObjFromRequest:(ASIHTTPRequest *)request serverReq:(RPServerRequest *)serverReq
{
    
    NSDictionary *jsonDic = [request.responseString JSONValue];
    RPServerResponse *response = [[RPServerResponse alloc] initWithJSONDic:jsonDic];
    response.operationType = serverReq.operationType;
    return response;
}



/**
 检查网络
 @returns 没有网络返回NO
 */
- (BOOL)checkNetWork
{
    Reachability *reachable = [Reachability reachabilityForInternetConnection];
    
    if (reachable.currentReachabilityStatus == NotReachable) {
        //如果之前的状态是连接中，那么报错提示
        if (_networking)
        {
            _networking = NO;
        }
        return NO;
    }else
    {
        if (!_networking)
        {
            _networking = YES;
        }
    }
    return YES;
}


+ (NSString *)host
{
#ifdef kTesting
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([userDef integerForKey:kOnline] == 0)
    {
        return kOnlineHost;
    }else if ([userDef integerForKey:kOnline] == 1)
    {
        return kPreOnlineHost;
    }else
    {
        return kDebugPushHost;
    }
#else
    //线上环境
    return kDebugHost;
#endif
    
}


@end
