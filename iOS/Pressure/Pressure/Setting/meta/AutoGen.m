//
//  AutoGen.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "AutoGen.h"
#import "AutoGenSection.h"
@implementation AutoGen


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _title  = jsonDic[@"title"];
        _tag    = [jsonDic[@"tag"] intValue];
        _style  = [self styleFromStyleStr:jsonDic[@"style"]];
        NSArray *array = jsonDic[@"sections"];
        _sections = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array)
        {
            
            AutoGenSection *section = [[AutoGenSection alloc] initWithJSONDic:dic];
            [_sections addObject:section];
        }
    }
    return self;
}


- (UITableViewStyle)styleFromStyleStr:(NSString *)styleStr
{
    if ([styleStr isEqualToString:@"UITableViewStylePlain"])
    {
        return UITableViewStylePlain;
    }
    if ([styleStr isEqualToString:@"UITableViewStyleGrouped"])
    {
        return UITableViewStyleGrouped;
    }
    return UITableViewStylePlain;
}
@end
