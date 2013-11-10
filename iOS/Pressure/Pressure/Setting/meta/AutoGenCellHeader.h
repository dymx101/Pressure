//
//  AutoGenCellHeader.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoGenCellHeader : NSObject

@property (nonatomic,copy) NSString *className;
@property (nonatomic) CGFloat height;
@property (nonatomic,copy) NSString *title;


- (id)initWithJSONDic:(NSDictionary *)jsonDic;
@end
