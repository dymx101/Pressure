//
//  NSDictionary+JSON.h
//  GameChat
//
//  Created by Tom on 2/28/13.
//  Copyright (c) 2013 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONRepresentation:(id)object;
@end
