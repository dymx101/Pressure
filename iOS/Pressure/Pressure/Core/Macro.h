//
//  Macro.h
//  AliSeller_AE
//
//  Created by 郑 eason on 13-10-14.
//  Copyright (c) 2013年 Alibaba. All rights reserved.
//

/****************************
 
 
 公共的方法库、模板
 
 
 
 
 
 ****************************/

#ifndef AliSeller_AE_Macro_h
#define AliSeller_AE_Macro_h

//#define Testing

/******
 
 常用逻辑函数
 
 ******/
#define STR(n) [NSString stringWithFormat:@"%d",n]
#define NUMI(x) [NSNumber numberWithInt:x]
#define NUMF(x) [NSNumber numberWithFloat:x]
#define NUMB(x) [NSNumber numberWithBool:x]
#define URL(urlStr) [NSURL URLWithString:urlStr]
#define LONGLONG2NUM(x) [NSNumber numberWithLongLong:(x)]
#define LONGLONG2STR(x) [NSString stringWithFormat:@"%lld", (x)]

#define SAFESTR(x) ((x)==nil)?@"":(x)
#define SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(A,B,C) if((B)!=nil){ [A setObject:(B) forKey:(C)];}



/******
 
 异常调试
 
 ******/
#ifndef DEBUG

#ifdef assert(e)
#undef assert(e)
#endif

#define	assert(e) \
if(!(e)) { printf("\n\t[ASSERT FAIL:%s line%d]\n\n", __FUNCTION__,__LINE__);}

#endif


#ifdef kTesting

    #define MLOG(format,...) [iConsole info:[NSString stringWithFormat:@"\n\t<%@ line%d>\n%@\n",[NSString stringWithUTF8String:__FUNCTION__],__LINE__,[NSString stringWithFormat:format, ##__VA_ARGS__]]];

    #define MLOGRECT(format,...) [iConsole info:[NSString stringWithFormat:@"\n\t<%@ line%d>\n%@\n",[NSString stringWithUTF8String:__FUNCTION__],__LINE__,NSStringFromCGRect(format, ##__VA_ARGS__)]];

    #define MWARNING(format,...) [iConsole info:[NSString stringWithFormat:@"\n\t［ WARNING ］<%@ line%d>\n%@\n",[NSString stringWithUTF8String:__FUNCTION__],__LINE__,[NSString stringWithFormat:format, ##__VA_ARGS__]]];
#elif DEBUG

    #define MLOG(...)  printf("\n\t<%s line%d>\n%s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
    #define MLOGRECT(...)  printf("\n\t<%s line%d>\n%s\n", __FUNCTION__,__LINE__,[NSStringFromCGRect(__VA_ARGS__) UTF8String])
    #define MWARNING(...)  printf("\n\t［ WARNING ］<%s line%d>\n%s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else

    #define MLOG(...)
    #define MLOGRECT(...)
    #define MWARNING(...)
#endif



/******
 
 颜色相关函数
 
 ******/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

/******
 
 本地化相关
 
 ******/
//#define T(str) NSLocalizedString(str,nil)

#endif
