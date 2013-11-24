//
//  RPFile.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPFile.h"
#define kUrl @"url"
#define kKey @"key"
#define kFileSize @"file_size"

@implementation RPFile

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _url = jsonDic[kUrl];
        _key = jsonDic[kKey];
        _fileSize = [jsonDic[kFileSize] intValue];
    }
    return self;
}

- (NSDictionary *)proxyForJson
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] initWithDictionary:[super proxyForJson]];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_url), kUrl);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_key), kKey);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(_fileSize), kFileSize);
    return mulDic;
}
@end
