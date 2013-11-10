//
//  RPUtilities.m
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPUtilities.h"

@implementation RPUtilities


+ (void)runOnMainQueueWithoutDeadlocking:(VoidBlockType)block {
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
    dispatch_async(dispatch_get_main_queue(), block);
    }
}


+ (BOOL)openUrl:(NSURL *)url
{
    if (!url)
    {
        return NO;
    }
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    return  NO;
}

@end
