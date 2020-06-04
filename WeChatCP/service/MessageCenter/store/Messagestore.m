//
//  Messagestore.m
//  WeChatCP
//
//  Created by lwy on 2020/5/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Messagestore.h"
#import "MessageSQL.h"
#import <MJExtension.h>
#import "User.h"


@implementation Messagestore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [DBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if(!ok) {
            NSLog(@"聊天记录表创建失败");
        }
    }
    return self;
}
- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_MESSAGE_TABLE, MESSAGE_TABLE_NAME];
    return [self createTable:MESSAGE_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addMessage:(Message *)message
{
    if (message == nil || message.dstID == nil) {
        return NO;
    }
    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE, MESSAGE_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        message.userID,
                        message.ID,
                        message.dstID,
                        [NSNumber numberWithInteger:message.partnerType],
                        [NSNumber numberWithInteger:message.ownerTyper],
                        [NSNumber numberWithInteger:message.messageType],
                        [message.content mj_JSONString],
                        [NSNumber numberWithInteger:message.sendState],
                        [NSNumber numberWithInteger:message.readState],
                        TimeStamp(message.date),
                        nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (NSNumber *)addMessageRetID:(Message *)message
{
    if (message == nil || message.dstID == nil) {
        return @0;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE, MESSAGE_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        message.userID,
                        @0,
                        message.dstID,
                        [NSNumber numberWithInteger:message.partnerType],
                        [NSNumber numberWithInteger:message.ownerTyper],
                        [NSNumber numberWithInteger:message.messageType],
                        [message.content mj_JSONString],
                        [NSNumber numberWithInteger:message.sendState],
                        [NSNumber numberWithInteger:message.readState],
                        TimeStamp(message.date),
                        nil];
    NSNumber *insertId = [self excuteAdd:sqlString withArrParameter:arrPara];
    return insertId;
}
- (void)messagesByUserID:(NSString *)userId dstId:(NSString *)dstId count:(NSUInteger)count complete:(void (^)(NSArray * _Nonnull, BOOL))complete
{
   
    __block NSMutableArray *data = [NSMutableArray array];
    NSString *sqlString = [NSString stringWithFormat:
                           SQL_SELECT_MESSAGES_PAGE,
                           MESSAGE_TABLE_NAME,
                           dstId,
                           (long)(count + 1)];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet * _Nonnull rsSet) {
        while ([rsSet next]) {
            Message *message = [self p_createDBMessageByFMResultSet:rsSet];
            if (message.ID != nil) {
                [data insertObject:message atIndex:0];
            }
        }
        [rsSet close];
    }];
    
    BOOL hasMore = NO;
    if (data.count == count + 1) {
        hasMore = YES;
        [data removeObjectAtIndex:0];
    }
    complete(data, hasMore);
}

- (Message *)lastMessageByUserID:(NSString *)dstId
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_MESSAGES_PAGE, MESSAGE_TABLE_NAME, dstId, (long)1];
    __block Message * message;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            message = [self p_createDBMessageByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return message;
}

#pragma mark - Private Methods -
- (Message *)p_createDBMessageByFMResultSet:(FMResultSet *)rsSet
{
    MessageType type = [rsSet intForColumn:@"msgType"];
    Message *message = [Message createMessageByType:type];
    message.ID = [NSNumber numberWithLongLong:[rsSet longLongIntForColumn:@"id"]];
    message.userID = [rsSet stringForColumn:@"userId"];
    message.dstID = [rsSet stringForColumn:@"dstId"];
    message.partnerType = [rsSet intForColumn:@"partnerType"];
    message.ownerTyper = [rsSet intForColumn:@"ownerType"];
    message.messageType = [rsSet intForColumn:@"msgType"];
    NSString *content = [rsSet stringForColumn:@"content"];
    message.content = [[NSMutableDictionary alloc] initWithDictionary:[content mj_JSONObject]];
    message.sendState = [rsSet intForColumn:@"sendState"];
    message.readState = [rsSet intForColumn:@"readState"];
    
    return message;
}
@end
