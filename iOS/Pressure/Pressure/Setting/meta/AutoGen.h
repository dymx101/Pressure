//
//  AutoGen.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoGen : NSObject


@property (nonatomic,copy) NSString *title;
@property (nonatomic) int tag;
@property (nonatomic) UITableViewStyle style;
@property (nonatomic,retain) NSMutableArray *sections;

- (id)initWithJSONDic:(NSDictionary *)jsonDic;
@end
