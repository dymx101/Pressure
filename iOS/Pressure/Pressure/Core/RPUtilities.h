//
//  RPUtilities.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^VoidBlockType)(void);
typedef void (^IntParamBlockType)(int);
typedef void (^NSStringBlockType)(NSString *);

@interface RPUtilities : NSObject


+ (void)runOnMainQueueWithoutDeadlocking:(VoidBlockType)block;
@end
