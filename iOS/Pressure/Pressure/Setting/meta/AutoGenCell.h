//
//  AutoGenCell.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-16.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _AutoGenCellType
{
    AutoGenCellType_None,
    AutoGenCellType_Link,
    AutoGenCellType_VCTL,
    AutoGenCellType_Plist,
    AutoGenCellType_Function
}AutoGenCellType;
@interface AutoGenCell : NSObject


@property (nonatomic,copy) NSString *className;
@property (nonatomic) CGFloat height;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *actionValue;
@property (nonatomic) AutoGenCellType actionType;

- (id)initWithJSONDic:(NSDictionary *)jsonDic;

@end
