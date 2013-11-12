//
//  RPAppModel.h
//  Pressure
//
//  Created by eason on 11/6/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPProfile;
@interface RPAppModel : RPObject


+ (RPAppModel *)sharedInstance ;

@property (nonatomic,retain) NSMutableArray *chatUserArray;



- (BOOL)dealWithFrMessage:(NSDictionary *)messageDic;
- (void)resetChatingUserState:(RPProfile *)chatingUser;
- (RPProfile *)chatingUser;
@end
