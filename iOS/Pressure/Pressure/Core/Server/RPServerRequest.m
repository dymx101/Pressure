//
//  RPServerRequest.m
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPServerRequest.h"
#import "JSON20.h"
#import "RPServerApiDef.h"
@implementation RPServerRequest

- (id)init
{
    self = [super init];
    if (self) {
        _params    = @{};
        _dataArray = @[];
        _requestCount    = 1;
        _maxRequestCount = 1;
    }
    return self;
}


- (BOOL)canRetryToReqServer
{
    return _requestCount < _maxRequestCount;
}



- (NSDictionary *)jsonStrCanPostToServer
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    if(_params)
    {
        [mulDic setDictionary:_params];
    }
    
    
    [self insertDefaultParam:mulDic];
    return mulDic;
}


- (void)insertDefaultParam:(NSMutableDictionary *)mulDic
{
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"zh-Hant"])
    {
        language = @"zh-TW";
    }else if ([language isEqualToString:@"zh-Hans"])
    {
        language = @"zh-CN";
    }else
    {
        language = @"en-US";
    }
    

//    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, kAPP_ID, kServerRequest_AppID);
    
//    UIDevice *device = [UIDevice currentDevice];
//    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [device uniqueDeviceIdentifier], kServerRequest_DeviceId);
    
//    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [ServerRequest platform], kServerRequest_ClientPlateform);
    
//    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [CSUtil buildVersion], kServerRequest_ClientVersion);
    
//    CGFloat version = [CSUtil systemVersion];
//    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, [NSNumber numberWithFloat:version], kServerRequest_PlateformVersion);
}

- (BOOL)needToken
{
    if ([_operationType isEqualToString:kServerApi_ThirdPartLogin])
    {
        return NO;
    }
    
    return YES;
}

@end
