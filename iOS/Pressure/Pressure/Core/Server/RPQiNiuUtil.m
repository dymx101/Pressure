//
//  RPQiNiuManager.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPQiNiuUtil.h"
#import "QiniuSimpleUploader.h"
#import "QiniuPutPolicy.h"
@interface RPQiNiuUtil ()
{
}
@end

@implementation RPQiNiuUtil

+ (NSString *)token
{
    QiniuPutPolicy *policy = [[QiniuPutPolicy alloc] init];
    policy.scope = QiniuBucketName;
    return [policy makeToken:QiniuAccessKey secretKey:QiniuSecretKey];
}


@end
