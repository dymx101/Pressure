//
//  RPMessage.m
//  Pressure
//
//  Created by eason on 11/7/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "RPMessage.h"
#import "FMDBObject.h"
#define kDBId @"id"
#define kUserId @"user_id"
#define kToUserId @"to_user_id"
#define kContent @"content"
#define kImgUrl @"img_url"
#define kVoiceUrl @"voice_url"
#define kReaded @"readed"
#define kTableName @"tb_message"
#define kType @"type"
@implementation RPMessage

- (id)initWithJSONDic:(NSDictionary *)jsonDic
{
    self = [super initWithJSONDic:jsonDic];
    if (self)
    {
        _dbId = [jsonDic[kDBId] longLongValue];
        _userId = [jsonDic[kUserId] longLongValue];
        _toUserId = [jsonDic[kToUserId] longLongValue];
        _content = jsonDic[kContent];
        _img_url = jsonDic[kImgUrl];
        _voice_url = jsonDic[kVoiceUrl];
        _readed = (RPMessage_ReadState)[jsonDic[kReaded] intValue];
    }
    return self;
}

- (NSDictionary *)proxyForJson
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(_userId), kUserId);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, LONGLONG2NUM(_toUserId), kToUserId);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_content), kContent);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_img_url), kImgUrl);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_voice_url), kVoiceUrl);
    SET_DICTIONARY_A_OBJ_B_FOR_KEY_C_ONLYIF_B_IS_NOT_NIL(mulDic, SAFESTR(_type), kType);
    return mulDic;
}


- (BOOL)saveToDB
{
    
    if (_dbId > 0)
    {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ set %@ = ? where %@ = ?",kTableName, kDBId, kReaded];
        return [[FMDBObject sharedInstance] executeUpdate:sql,LONGLONG2NUM(_dbId),NUMI(_readed)];
    }else
    {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@,%@,%@) VALUES (?,?,?,?,?,?)",kTableName,kUserId,kToUserId,kContent,kImgUrl,kVoiceUrl,kReaded];
        return [[FMDBObject sharedInstance] executeUpdate:sql,LONGLONG2NUM(_userId),LONGLONG2NUM(_toUserId),SAFESTR(_content),SAFESTR(_img_url),SAFESTR(_voice_url),NUMI(_readed)];
    }

}


+ (NSArray *)messageFromDB:(long long)fromUserId toUserId:(long long)toUserId dbId:(long long)dbId
{
    FMDBObject *db = [FMDBObject sharedInstance];
    NSString *sql ;
    if (dbId > 0)
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ where ((%@ = %lld and %@ = %lld) or (%@ = %lld and %@ = %lld)) and %@ < %lld order by id desc limit 20",kTableName, kUserId , fromUserId,kToUserId, toUserId,kUserId,toUserId,kToUserId,fromUserId,kDBId,dbId];
    }else
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ where ((%@ = %lld and %@ = %lld) or (%@ = %lld and %@ = %lld)) order by id desc limit 20",kTableName, kUserId , fromUserId,kToUserId, toUserId,kUserId,toUserId,kToUserId,fromUserId];
    }
    
    FMResultSet *rs = [db executeQuery:sql];
    
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    while ([rs next]) {
        RPMessage *message = [[RPMessage alloc] init];
        message.dbId = [rs longLongIntForColumn:kDBId];
        message.userId = [rs longLongIntForColumn:kUserId];
        message.toUserId = [rs longLongIntForColumn:kToUserId];
        message.content = [rs stringForColumn:kContent];
        message.img_url = [rs stringForColumn:kImgUrl];
        message.voice_url = [rs stringForColumn:kVoiceUrl];
        message.readed = [rs intForColumn:kReaded];
        [messages addObject:message];
    }
    
    return messages;
    
}

+ (NSString *)rpMessageUserIdKey
{
    return kUserId;
}

+ (NSString *)rpMessageTypeKey
{
    return kType;
}
@end
