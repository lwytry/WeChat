//
//  ConversationSQL.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#ifndef ConversationSQL_h
#define ConversationSQL_h

#define     CONVERSATION_TABLE_NAME             @"conversation"

/*
 * id 主键
 * uId 用户id
 * type 回话类型0 默认聊天 1群聊
 * unreadCount 未读条数
 * date 最新更新时间
 */
#define     SQL_CREATE_CONVERSATION_TABLE       @"CREATE TABLE IF NOT EXISTS %@(\
                                                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\
                                                uId TEXT,\
                                                type INTEGER DEFAULT (0),\
                                                unreadCount INTEGER DEFAULT (0),\
                                                date TEXT)"

#define     SQL_SELECT_CONVERSATION             @"SELECT * FROM %@ ORDER BY date DESC"
#define     SQL_ADD_CONVERSATION                @"INSERT INTO %@ (uId, type, unreadCount, date) VALUES ( ?, ?, ?, ?)"
#define     SQL_UPDATE_CONVERSATION             @"UPDATE %@ SET unreadCount = ?, date = ? WHERE uId = %@"
#define     SQL_SELECT_CONVERSATION_UNREAD      @"SELECT unreadCount FROM %@ WHERE uId = %@"
#define     SQL_UPDATE_UNREAD                   @"UPDATE %@ SET unreadCount = ? WHERE uId = %@"
#define     SQL_SELECT_CONVERSATION_BY_UID      @"SELECT id FROM %@ WHERE uId = %@"
#endif /* ConversationSQL_h */
