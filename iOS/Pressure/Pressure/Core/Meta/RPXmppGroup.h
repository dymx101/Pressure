//
//  RPXmppGroup.h
//  Pressure
//
//  Created by eason on 11/7/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"

@interface RPXmppGroup : RPObject


@property (nonatomic) long long groupId;
@property (nonatomic,copy) NSString *groupName;
@end
