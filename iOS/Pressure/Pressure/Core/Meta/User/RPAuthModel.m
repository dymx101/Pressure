//
//  RPAuthModel.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAuthModel.h"
#import "RPProfile.h"
#import "RPThirdModel.h"
#import "RPXmppProfile.h"
#import "RPSession.h"
static __strong NSMutableArray * historyLoginUsersList = nil;
static RPAuthModel * authModel = nil;
@implementation RPAuthModel

+ (RPAuthModel *)sharedInstance
{
    @try {
        
        if (historyLoginUsersList == nil)
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [NSString stringWithFormat:@"%@/Caches/user.arch",paths[0]];
            NSMutableArray * models = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:path];
            
            if (models != nil && [models count] > 0)
            {
                historyLoginUsersList = models;
                authModel = historyLoginUsersList[0];
                
            }else
            {
                historyLoginUsersList = [[NSMutableArray alloc] init];
                authModel = nil;
            }
        }
        
    }
    @catch (NSException *exception) {
        MLOG(@"expction %@",exception);
    }
    @finally {
        
    }

    if (authModel == nil)
    {
        authModel = [[RPAuthModel alloc] init];
        authModel.connectedOpenFireSucc = NO;
    }
    return  authModel;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _profile = [[RPProfile alloc] init];
        _session = [[RPSession alloc] init];
        _thirdModel = [[RPThirdModel alloc] init];

    }
    return self;
}

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _profile = [[RPProfile alloc] init];
        _session = [[RPSession alloc] init];
        _thirdModel = [[RPThirdModel alloc] init];
    }
    return self;
}


- (void)setLoginSuccValue:(NSDictionary *)jsonDic
{
    _profile = [[RPProfile alloc] initWithJSONDic:jsonDic[kMetaKey_Profile]];
    _session = [[RPSession alloc] initWithJSONDic:jsonDic[kMetaKey_Session]];
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
    if (_session && _session.refreshToken && ![_session.refreshToken isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}


- (BOOL)serverLogined
{
    return YES;
}


/**
 *  保存数据
 */
- (void)saveData
{
    @try {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [NSString stringWithFormat:@"%@/Caches/user.arch",paths[0]];
        
        assert(self.profile.userId > 0);
        
        // search history login user list.
        BOOL existCurUser = NO;
        int i = 0;
        for ( ;i< [historyLoginUsersList count]; i++)
        {
            RPAuthModel * model = historyLoginUsersList[i];
            if (model.profile.userId == self.profile.userId)
            {
                if (i!=0)
                {
                    existCurUser = YES;
                    break;
                }
            }
        }
        
        // exchange or add new user ?
        existCurUser?[historyLoginUsersList exchangeObjectAtIndex:i withObjectAtIndex:0]: [historyLoginUsersList insertObject:self atIndex:0];;
        
        [NSKeyedArchiver archiveRootObject:historyLoginUsersList toFile:path];
        
    }
    @catch (NSException *exception) {
        MLOG(@"%@",exception);
    }
    @finally {
        
    }
    
}



@end
