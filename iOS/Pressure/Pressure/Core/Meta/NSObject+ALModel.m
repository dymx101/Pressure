//
//  NSObject+ALModel.m
//  ATM
//
//  Created sugar on 13-8-9.
//  Copyright (c) 2013年 haitaotong. All rights reserved.
//

#import "NSObject+ALModel.h"
#include <objc/runtime.h>

@implementation NSObject (ALModel)

- (void)encodeWithCoder:(NSCoder *)encoder {
	Class cls = [self class];
    @synchronized (self)
    {
        while (cls != [NSObject class]) {
            unsigned int numberOfIvars = 0;
            Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
            for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)
            {
                Ivar const ivar = *p;
                const char *type = ivar_getTypeEncoding(ivar);
                NSString *key = @(ivar_getName(ivar));
                id value = [self valueForKey:key];
                if (value) {
                    switch (type[0]) {
                        case _C_STRUCT_B:
                        {
                            NSUInteger ivarSize = 0;
                            NSUInteger ivarAlignment = 0;
                            NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                            NSData *data = [NSData dataWithBytes:(const char *)self + ivar_getOffset(ivar)
                                                          length:ivarSize];
                            [encoder encodeObject:data forKey:key];
                        }
                            break;

                        default:
                            [encoder encodeObject:value
                                           forKey:key];
                            break;
                    }
                }
            }
            if (ivars) {
                free(ivars);
            }
            
            cls = class_getSuperclass(cls);
        }
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
	
	
    @synchronized (self)
    {
        if (self) {
            Class cls = [self class];
            while (cls != [NSObject class]) {
                unsigned int numberOfIvars = 0;
                Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
                
                for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)
                {
                    Ivar const ivar = *p;
                    const char *type = ivar_getTypeEncoding(ivar);
                    NSString *key = @(ivar_getName(ivar));
                    id value = [decoder decodeObjectForKey:key];
                    if (value) {
                        switch (type[0]) {
                            case _C_STRUCT_B: {
                                NSUInteger ivarSize = 0;
                                NSUInteger ivarAlignment = 0;
                                NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);				
                                NSData *data = [decoder decodeObjectForKey:key];
                                char *sourceIvarLocation = (char*)self+ ivar_getOffset(ivar);								 
                                [data getBytes:sourceIvarLocation length:ivarSize];
                                memcpy((char *)self + ivar_getOffset(ivar), sourceIvarLocation, ivarSize);
                            }
                                break;
                            default:
                                [self setValue:[decoder decodeObjectForKey:key]
                                        forKey:key];
                                break;
                        }
                    }			
                }
                
                if (ivars) {
                    free(ivars);
                }
                cls = class_getSuperclass(cls);
            }
        }
	}
	return self;
}

@end
