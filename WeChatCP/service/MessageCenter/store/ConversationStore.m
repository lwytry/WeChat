//
//  ConversationStore.m
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ConversationStore.h"
#import "ConversationSQL.h"
#import "Messagestore.h"
#import "Conversation.h"
#import "ContactHelper.h"

@interface ConversationStore()

@property (nonatomic, strong) Messagestore *messageStore;

@end

@implementation ConversationStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [DBManager sharedInstance].messageQueue;
        BOOL ok = [self createTabel];
        if (!ok) {
            NSLog(@"聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTabel
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CONVERSATION_TABLE, CONVERSATION_TABLE_NAME];
    return [self createTable:CONVERSATION_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addConversationByUId:(NSString *)uId type:(NSInteger)type date:(NSDate *)date
{
    NSInteger unreadCount = [self unreadMessageByUId:uId] + 1;
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_CONVERSATION, CONVERSATION_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        uId,
                        [NSNumber numberWithInteger:type],
                        [NSNumber numberWithInteger:unreadCount],
                        TimeStamp(date),
                        nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (BOOL)updateConversationByUId:(NSString *)uId date:(NSDate *)date
{
    NSInteger unreadCount = [self unreadMessageByUId:uId] + 1;
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_CONVERSATION, CONVERSATION_TABLE_NAME, uId];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        [NSNumber numberWithInteger:unreadCount],
                        TimeStamp(date),
                        nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (NSArray *)conversationGetAll
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_CONVERSATION, CONVERSATION_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            Conversation *conversation = [[Conversation alloc] init];
            conversation.dstID = [retSet stringForColumn:@"uId"];
            conversation.convType = [retSet intForColumn:@"type"];
            NSString *dateString = [retSet stringForColumn:@"date"];
            conversation.date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue];
            conversation.unreadCount = [retSet intForColumn:@"unreadCount"];
            [data addObject:conversation];
        }
        [retSet close];
    }];
    
    // 获取conv对应的msg
    for (Conversation *conversation in data) {
        
        Message * message = [self.messageStore lastMessageByUserID:conversation.dstID];
        if (message) {
            conversation.content = [message conversationContent];
            conversation.date = message.date;
            User *user = [[ContactHelper sharedContactHelper] getContactInfoByUserId:conversation.dstID];
            conversation.avatarURL = user.avatarURL;
            conversation.dstName = user.userName;
        }
    }
    
    return data;
}

- (NSInteger)unreadMessageByUId:(NSString *)uId
{
    __block NSInteger unreadCount = 0;
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CONVERSATION_UNREAD, CONVERSATION_TABLE_NAME, uId];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        if ([retSet next]) {
            unreadCount = [retSet intForColumn:@"unreadCount"];
        }
        [retSet close];
    }];
    return unreadCount;
}

#pragma mark - Getter -
- (Messagestore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[Messagestore alloc] init];
    }
    return _messageStore;
}

@end
