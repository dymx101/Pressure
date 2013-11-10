//
//  NSString+Addition.h
//  ATM
//
//  Created by 郑 eason on 13-7-25.
//  Copyright (c) 2013年 haitaotong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

- (BOOL)containStr:(NSString*)matchStr;

- (BOOL)isEmpty;

- (BOOL)pd_findSubstring:(NSString*)sub;


@end
