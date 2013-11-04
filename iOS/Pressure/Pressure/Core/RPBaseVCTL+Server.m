//
//  RPBaseVCTL+Server.m
//  Pressure
//
//  Created by eason on 11/4/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPBaseVCTL+Server.h"
#import "RPServerApiDef.h"
@implementation RPBaseVCTL (Server)


/**
 非线程调用
 @param callURL 调用的operationType
 @param dic 传入参数
 @returns 返回内容
 */
- (void)serverCall:(NSString *)operationType data:(NSDictionary *)dic
{
    RPServerOperation *operation = [RPServerOperation sharedInstance];
    RPServerRequest *serverReq = [operation generateDefaultServerRequest:self operationType:operationType dic:dic];
    
    [operation syncToServerByRequest:serverReq];
}


/**
 异步调用
 @param operationType 调用的operationType
 @param dic 传入参数
 */
- (void)asynServerCall:(NSString *)operationType data:(NSDictionary *)dic
{
    RPServerOperation *operation = [RPServerOperation sharedInstance];
    RPServerRequest *serverReq = [operation generateDefaultServerRequest:self operationType:operationType dic:dic];
    
    [operation asyncToServerByRequest:serverReq];
}


#pragma mark -
#pragma mark ServerRequest Delegate
- (void)updateUI:(RPServerResponse *)serverResp
{
    
    if ([serverResp.operationType isEqualToString:kServerApi_FrMatch])
    {
        if (serverResp.code == RPServerResponseCode_Succ)
        {
            
        }
    }
}



#pragma mark -
#pragma mark ServerResponse Delegate
- (void)serverRequestDidSyncCallback:(RPServerResponse *)serverResp
{
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:serverResp waitUntilDone:NO];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)removeViewRequest
{
    RPServerOperation *operation = [RPServerOperation sharedInstance];
    [operation removeRequestTarget:self];
}
#pragma clang diagnostic pop


@end
