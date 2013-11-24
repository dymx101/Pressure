//
//  RPBaseVCTL+Server.h
//  Pressure
//
//  Created by eason on 11/4/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPBaseVCTL.h"

@interface RPBaseVCTL (Server)

- (void)serverCall:(NSString *)operationType data:(NSDictionary *)dic;
- (void)asynServerCall:(NSString *)operationType data:(NSDictionary *)dic;
@end
