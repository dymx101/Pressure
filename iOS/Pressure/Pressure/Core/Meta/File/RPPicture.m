//
//  RPPicture.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPPicture.h"
#define kWidth @"width"
#define kHeight @"height"
@implementation RPPicture

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _width  = [jsonDic[kWidth] intValue];
        _height = [jsonDic[kHeight] intValue];
        
    }
    return self;
}

- (NSDictionary *)proxyForJson
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] initWithDictionary:[super proxyForJson]];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(_width), kWidth);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(_height), kHeight);
    return mulDic;
}
@end
