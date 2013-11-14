//
//  RPQiNiuManager.m
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPQiNiuManager.h"
#import "QiniuSimpleUploader.h"
#import "QiniuPutPolicy.h"
@interface RPQiNiuManager () <QiniuUploadDelegate>
{
    VoidBlockType _succ;
    VoidBlockType _failed;
}
@end
@implementation RPQiNiuManager

- (void)uploadImageWithPath:(NSString *)path
                        key:(NSString *)key
                       succ:(VoidBlockType)succ
                     failed:(VoidBlockType)failed
{
    QiniuSimpleUploader *uploader = [QiniuSimpleUploader uploaderWithToken:[self tokenWithScope:QiniuBucketName]];
    uploader.delegate = self;
    [uploader uploadFile:path key:key extra:nil];
}

- (NSString *)tokenWithScope:(NSString *)scope
{
    QiniuPutPolicy *policy = [[QiniuPutPolicy alloc] init];
    policy.scope = scope;
    
    return [policy makeToken:QiniuAccessKey secretKey:QiniuSecretKey];
}

#pragma mark -
#pragma mark QiniuUploadDelegate
- (void)uploadSucceeded:(NSString *)filePath ret:(NSDictionary *)ret
{
    if (_succ)
    {
        _succ();
    }
}

- (void)uploadFailed:(NSString *)filePath error:(NSError *)error
{
    if (_failed)
    {
        _failed();
    }
}


@end
