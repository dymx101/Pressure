//
//  FMDBObject.m
//  ATM
//
//  Created by 郑 eason on 13-8-7.
//  Copyright (c) 2013年 haitaotong. All rights reserved.
//

#import "FMDBObject.h"

#define kDatabase @"mainDB.sqlite"
@implementation FMDBObject
static dispatch_once_t  onceToken;
static FMDBObject * db;
- (id)init
{
    return [FMDBObject sharedInstance];
}

+ (FMDBObject *)sharedInstance
{
    
    dispatch_once(&onceToken, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *document = paths[0];
        NSString *dbPath = [document stringByAppendingPathComponent:kDatabase];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL succ = [fileManager fileExistsAtPath:dbPath];

        if (!succ)
        {
            NSError *error;
            // The writable database does not exist, so copy the default to the appropriate location.
            NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabase];
            succ = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
            if (!succ) {
                db = nil;
            }

        }
        db = [FMDatabase databaseWithPath:dbPath];
        
        if (![db open])
        {
            MLOG(@"************* database can't open error!!!! ***************");
            db = nil;
        }

        
    });
    return db;
}




@end
