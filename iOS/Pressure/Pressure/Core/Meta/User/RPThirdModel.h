//
//  RPSinaModel.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
typedef enum _RPThirdModelType
{
    RPThirdModelType_SinaWeiBo = 1
}RPThirdModelType;
@interface RPThirdModel : RPObject

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic) long long expires_in;
@property (nonatomic) RPThirdModelType type;


@end
