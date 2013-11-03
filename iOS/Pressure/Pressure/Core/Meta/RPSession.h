//
//  RPSession.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"

@interface RPSession : RPObject

@property (nonatomic,copy) NSString *refreshToken;
@property (nonatomic) long long expire_in;

@end
