//
//  RPAuthModel.h
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPObject.h"
#import "NSObject+ALModel.h"
@class RPThirdModel;
@class RPProfile;
@class RPSession;
@interface RPAuthModel : RPObject

@property (nonatomic,retain) RPThirdModel *thirdModel;
@property (nonatomic,retain) RPProfile *profile;
@property (nonatomic,retain) RPSession *session;

@property (nonatomic) BOOL connectedOpenFireSucc;
@property (nonatomic) BOOL userXmppOnline;
+ (RPAuthModel *)sharedInstance;

//判断本地是否已经登录
- (BOOL)logined;
//判断token是否有效的登录
- (BOOL)serverLogined;

- (void)setLoginSuccValue:(NSDictionary *)jsonDic;

- (void)saveData;



@end
