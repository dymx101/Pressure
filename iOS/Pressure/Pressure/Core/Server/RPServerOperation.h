//
//  RPServerOperation.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import <Foundation/Foundation.h>



@class RPServerRequest;
@interface RPServerOperation : NSObject


@property (nonatomic) BOOL networking;


+ (RPServerOperation *) sharedInstance;


- (RPServerRequest *)generateDefaultServerRequest:(id)target
                                  operationType:(NSString *)operationType
                                            dic:(NSDictionary *)dic;

- (void)removeRequestTarget:(id)target;

- (void)syncToServerByRequest:(RPServerRequest *)serverRequest;
- (void)asyncToServerByRequest:(RPServerRequest *)serverRequest;



- (BOOL)checkNetWork;

+ (NSString *)host;
@end
