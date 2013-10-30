//
//  RPAuthModel.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAuthModel.h"
#import "RPProfile.h"
#import "RPSinaModel.h"
#import "RPXmppProfile.h"
#define kProfile @"profile"
static RPAuthModel * authModel = nil;
@implementation RPAuthModel


+ (RPAuthModel *)sharedInstance
{
    if (authModel == nil)
    {
        authModel = [[RPAuthModel alloc] init];
    }
    return  authModel;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kProfile]];
        
    }
    return self;
}

- (NSDictionary *)proxyForJson
{
    return [NSDictionary dictionary];
}

- (void)setWithJSONDic:(NSDictionary *)dic
{
    
    //子类继承
}


- (BOOL)logined
{
    return YES;
}

@end
