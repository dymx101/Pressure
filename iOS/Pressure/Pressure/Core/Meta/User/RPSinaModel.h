//
//  RPSinaModel.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"

@interface RPSinaModel : RPObject

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic) long long expires_in;


@end
