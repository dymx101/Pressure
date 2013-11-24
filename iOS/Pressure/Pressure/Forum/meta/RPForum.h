//
//  RPForum.h
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"
@class RPProfile;
@class RPPicture;
@class RPAudio;
@interface RPForum : RPObject

@property (nonatomic) long long forum_id;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,retain) RPAudio *audio;
@property (nonatomic,retain) RPPicture *picture;
@property (nonatomic) long long createTime;
@property (nonatomic) long long updateTime;
@property (nonatomic) int status;
@property (nonatomic) int chatType;
@property (nonatomic,retain) RPProfile *profile;
@end
