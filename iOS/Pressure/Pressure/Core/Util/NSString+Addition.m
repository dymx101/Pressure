//
//  NSString+Addition.m
//  ATM
//
//  Created by 郑 eason on 13-7-25.
//  Copyright (c) 2013年 haitaotong. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (BOOL)containStr:(NSString*)matchStr
{
  NSRange range = [self rangeOfString:matchStr];
  if(range.location == NSNotFound) {
    return NO;
  }
  return YES;
}

- (BOOL)isEmpty
{
  
  if([self isEqualToString:@""]|| (id)self == [NSNull null]){
    return YES;
  }
  return NO;
}

- (BOOL)pd_findSubstring:(NSString*)sub{
	
	if(sub){
		if([sub length]>0){
			NSRange range = [self rangeOfString:sub];
			return range.length ==0? NO:YES;
		}
		return YES;
	}
	
	return NO;
}

@end
