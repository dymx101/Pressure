//
//  AutoGenCell.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "AutoGenCell.h"

@implementation AutoGenCell


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _className = jsonDic[@"className"];
        _height    = [jsonDic[@"height"] floatValue];
        _title     = jsonDic[@"title"];
        _actionValue = jsonDic[@"actionValue"];
        _actionType = [self cellTypeFromTypeStr:jsonDic[@"actionType"]];
        
    }
    return self;
}

- (AutoGenCellType)cellTypeFromTypeStr:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"AutoGenCellType_Link"])
    {
        return AutoGenCellType_Link;
    }
    if ([typeStr isEqualToString:@"AutoGenCellType_VCTL"])
    {
        return AutoGenCellType_VCTL;
    }
    if ([typeStr isEqualToString:@"AutoGenCellType_Plist"])
    {
        return AutoGenCellType_Plist;
    }
    if ([typeStr isEqualToString:@"AutoGenCellType_Function"])
    {
        return AutoGenCellType_Function;
    }
    return AutoGenCellType_None;
}

@end
