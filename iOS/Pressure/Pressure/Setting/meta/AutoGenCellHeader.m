//
//  AutoGenCellHeader.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "AutoGenCellHeader.h"

@implementation AutoGenCellHeader

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _className = jsonDic[@"className"];
        _height    = [jsonDic[@"height"] floatValue];
        _title     = jsonDic[@"title"];
    }
    return self;
}

@end
