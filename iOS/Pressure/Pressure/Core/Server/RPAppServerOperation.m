//
//  RPAppServerOperation.m
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPAppServerOperation.h"
#import "SynthesizeSingleton.h"
@implementation RPAppServerOperation


SYNTHESIZE_SINGLETON_FOR_CLASS(RPAppServerOperation)

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSinaWeiboAuthSuccNotif:) name:kNotif_SinaWeiBoAuthSucc object:nil];
    }
    return self;
}


- (void)handleSinaWeiboAuthSuccNotif:(NSNotification *)notif
{
    //新浪微博登录后，发请求做登录操作
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
