//
//  RPVoice.m
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPAudio.h"
#define kAudio_Sec @"audio_sec"
@implementation RPAudio


- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _audio_sec = [jsonDic[kAudio_Sec] intValue];
    }
    return self;
}

- (NSDictionary *)proxyForJson
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] initWithDictionary:[super proxyForJson]];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, NUMI(_audio_sec), kAudio_Sec);
    return mulDic;
}
@end
