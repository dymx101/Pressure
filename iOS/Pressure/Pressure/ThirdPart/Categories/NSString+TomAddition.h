//
//  NSString+TomAddition.h
//
//  Created by Chen Jianfei on 2/11/11.
//  Copyright 2011 Fakastudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define		kMaxPixelOfCellHeight	1000
#define		kMinFontSize			16

@interface NSString (TomAddition)


- (BOOL)pd_isTrueString;
- (BOOL)pd_isNotEmptyString;

// 日期类
- (NSDate*)pd_yyyyMMddHHmmssDate;
- (NSDate*)pd_yyyyMMddHHmmDate;
- (NSDate*)pd_yyyyMMddDate;
- (NSDate*)pd_yyyyMdDate;
- (NSDate*)pd_yyyyMMddEEDate;
- (NSDate*)pd_yyyyMMdd1Date ;
- (NSDate*)pd_yyyyMMddThhmmssZZZDate;//统一的时间日期字符串格式2012-11-02T14:42:52+0800

- (NSDate*)pd_yyyyMMddHHmmss1Date;//yyyy:MM:ddHH:mm:ss

- (NSUInteger) pd_wrapStringHeight:(UIFont*)font withWidth:(NSUInteger)width withMinimalHeight:(NSUInteger)minimalHeight;
- (NSUInteger) pd_wrapStringLines:(UIFont*)font withWidth:(NSUInteger)width;

//去除前后空格
- (NSString *)pd_trimWhiteSpace;

// 左边数第一个left，右边数第一个end
- (NSString*)pd_substringWithRangeOfStartString:(NSString*)start endString:(NSString*)end;

// 左边数第一个left，再出现的下一个next
- (NSString*)pd_substringWithRangeOfStartString:(NSString *)start nextString:(NSString*)next;

// 左边数第一个left，再出现的下一个next, 两个next哪个先出现就截止到哪个
- (NSString*)pd_substringWithRangeOfStartString:(NSString *)start nextString:(NSString*)next1 orNextString:(NSString*)next2;

- (BOOL)pd_findSubstring:(NSString*)sub;

- (BOOL)isEmpty;

- (BOOL)isContainString:(NSString*)matchStr;


// 返回index的位置ASCII字符
- (char)pd_asciiAtIndexOf:(NSUInteger)index;

// 格式为xxx=111111&xxxxx=2222的字符串转化为key value的NSDictionary
+ (NSDictionary *)pd_parseURLQueryString:(NSString *)queryString;

- (BOOL)isAppStoreLink;

@end
