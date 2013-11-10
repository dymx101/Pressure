//
//  NSObject+ALModel.h
//  ATM
//
//  Created by sugar on 13-8-9.
//  Copyright (c) 2013年 haitaotong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ALModel) <NSCoding>

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
