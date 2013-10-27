//
//  NSDictionary+JSON.m
//  GameChat
//
//  Created by Tom on 2/28/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import "NSDictionary+JSON.h"
#import "NSString+SBJSON.h"

@implementation NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONRepresentation:(id)object {
  
  if([object isKindOfClass:[NSDictionary class]]){
    
    return object;
  }else if([object isKindOfClass:[NSString class]]){
    
    NSString *str=(NSString*)object;
    return [str JSONValue];
  }
            
  return nil;
}

@end
