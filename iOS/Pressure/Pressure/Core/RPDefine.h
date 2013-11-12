//
//  RPDefine.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#ifndef Pressure_RPDefine_h
#define Pressure_RPDefine_h

#define kXMPPHost                   @"192.168.1.7"
#define kSinaRegisterKey            @"246524502"
#define kOnlineHost     @"https://21beizi.com"
#define kDebugHost      @"http://192.168.1.7"

#define QiniuAccessKey  @"4nCMXPjlzgcXFlOY644w4UbuYuOVa8B2Ryjv_-IR"
#define QiniuSecretKey  @"6rav38-nmWQ-n4LRkxYfoc9aBn8wgnm6IcrAEDY8"
#define QiniuBucketName @"testpressure"


//界面ui宽高
#define SCREEN_HEADER_HEIGHT 49
#define SCREEN_STATUS_BAR_HEIGHT 20
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREEN_HEIGHT_WITHOUT_STATUS_BAR  ([[UIScreen mainScreen] bounds].size.height-20)
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//键盘高度
#define Default_KeyBoardHeight 216



#define Default_Medium_Gray UIColorFromRGB(0x666666)
#define Default_LowLow_Gray UIColorFromRGB(0xcdcdcd)
#define Default_Low_Gray    UIColorFromRGB(0x999999)
#define Default_Deep_Black  UIColorFromRGB(0x333333)



#endif
