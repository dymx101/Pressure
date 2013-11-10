//
//  AutoGenSection.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AutoGenCellHeader;
@interface AutoGenSection : NSObject


@property (nonatomic,retain) NSMutableArray *cells;
@property (nonatomic,retain) AutoGenCellHeader *header;

- (id)initWithJSONDic:(NSDictionary *)jsonDic;
@end
