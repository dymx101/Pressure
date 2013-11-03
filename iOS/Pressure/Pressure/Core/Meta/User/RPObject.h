//
//  RPObject.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPMetaKeyDef.h"
@interface RPObject : NSObject


- (id)initWithJSONDic:(NSDictionary *)jsonDic ;
- (void)setWithJSONDic:(NSDictionary *)dic;
- (NSDictionary *)proxyForJson;



@end
