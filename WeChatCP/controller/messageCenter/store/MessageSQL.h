//
//  MessageSQL.h
//  WeChatCP
//
//  Created by lwy on 2020/5/18.
//  Copyright © 2020 lwy. All rights reserved.
//

#ifndef MessageSQL_h
#define MessageSQL_h

#define     MESSAGE_TABLE_NAME              @"message"

/*
 * id 主键
 * userId
 * sourceId 对方来源id 用于撤回
 * dstId 对方id
 * partnerType 0用户 1群组
 * ownerType 0 未知的消息拥有者 1 系统消息 2 自己发送的消息 3 接收到的他人消息
 * msgType 0 文字 1 图片 2 表情 3 语音 4 视频 5 链接 6 位置 7 名片 8 系统 9其他
 * content json 具体内容
 * sendState 发送状态 0 已发送 1发送失败 2 已撤回
 * readState 读取状态 0 未读 1已读
 * createAt 创建时间 发送时间
 */
#define     SQL_CREATE_MESSAGE_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\
                                                userId TEXT NOT NULL DEFAULT '',\
                                                sourceId TEXT NOT NULL DEFAULT '',\
                                                dstId TEXT NOT NULL DEFAULT '',\
                                                partnerType INTEGER(1) NOT NULL,\
                                                ownerType INTEGER(1) NOT NULL DEFAULT 0,\
                                                msgType INTEGER(1) NOT NULL DEFAULT 1,\
                                                content TEXT DEFAULT '',\
                                                sendState INTEGER(1) NOT NULL DEFAULT 1,\
                                                readState INTEGER(1) NOT NULL DEFAULT 0,\
                                                createAt TEXT)"


#define     SQL_ADD_MESSAGE                 @"INSERT INTO %@ (userId, sourceId, dstId, partnerType, ownerType, msgType, content, sendState, readState, createAt) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     SQL_SELECT_MESSAGES_PAGE        @"SELECT * FROM %@ WHERE dstId = '%@' order by createAt desc LIMIT '%ld'"
#define     SQL_SELECT_CHAT_FILES           @"SELECT * FROM %@ WHERE uId = '%@' and dstId = '%@' and msgType = '2'"
#define     SQL_SELECT_CHAT_MEDIA           @"SELECT * FROM %@ WHERE uId = '%@' and dstId = '%@' and msgType = '2'"
#define     SQL_SELECT_LAST_MESSAGE         @"SELECT * FROM %@ WHERE createAt = ( SELECT MAX(createAt) FROM %@ WHERE uId = '%@' and detId = '%@' )"


#define     SQL_DELETE_MESSAGE              @"DELETE FROM %@ WHERE id = '%@'"
#define     SQL_DELETE_FRIEND_MESSAGES      @"DELETE FROM %@ WHERE uId = '%@' and dstId = '%@'"
#define     SQL_DELETE_USER_MESSAGES        @"DELETE FROM %@ WHERE uId = '%@'"

#endif /* MessageSQL_h */
