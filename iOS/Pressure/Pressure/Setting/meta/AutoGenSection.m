//
//  AutoGenSection.m
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import "AutoGenSection.h"
#import "AutoGenCellHeader.h"
#import "AutoGenCell.h"
@implementation AutoGenSection

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    
    self = [super init];
    if (self)
    {
        _header = [[AutoGenCellHeader alloc] initWithJSONDic:jsonDic[@"header"]];
        
        NSArray *array = jsonDic[@"cells"];
        _cells = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array)
        {
            AutoGenCell *cell = [[AutoGenCell alloc] initWithJSONDic:dic];
            [_cells addObject:cell];
        }
    }
    return self;
}
@end
