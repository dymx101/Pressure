//
//  RPAppModel.m
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPAppModel.h"
#import "RPMessage.h"
#import "JSON20.h"
#import "RPProfile.h"
static RPAppModel *appModel = nil;
@implementation RPAppModel


+ (RPAppModel *)sharedInstance {
    
    if (!appModel)
    {
        appModel = [[RPAppModel alloc] init];
    }
    return appModel;
}
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}



@end
