//
//  RPProfile.h
//  Pressure
//
//  Created by 郑 eason on 13-10-29.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPXmppProfile;
typedef enum _RPProfile_Gender
{
    RPProfile_Gender_Male ,
    RPProfile_Gender_Female
}RPProfile_Gender;

@interface RPProfile : RPObject

@property (nonatomic) long long userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *avatarUrl;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic) int age;
@property (nonatomic,copy) NSString *city;
@property (nonatomic) RPProfile_Gender gender;
@property (nonatomic,retain) RPXmppProfile *xmppProfile;


- (NSString *)genderStr;

@end
