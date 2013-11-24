//
//  RPFile.h
//  Pressure
//
//  Created by eason on 11/23/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPObject.h"

@interface RPFile : RPObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *key;
@property (nonatomic) int fileSize;
@property (nonatomic,copy) NSString *localFilePath;
@end
