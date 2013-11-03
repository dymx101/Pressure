//
//  RPServerResponse.m
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPServerResponse.h"
#define kCode @"code"
#define kData @"data"
@implementation RPServerResponse



- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    
    if (self)
    {
        if (jsonDic && (id)jsonDic != [NSNull null])
        {
            _code = [jsonDic[kCode] intValue];
            _obj    = jsonDic[kData];
        }
        
    }
    return self;
}
@end
