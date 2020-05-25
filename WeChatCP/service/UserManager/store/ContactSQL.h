//
//  ContactSQL.h
//  WeChatCP
//
//  Created by lwy on 2020/5/24.
//  Copyright © 2020 lwy. All rights reserved.
//

#ifndef ContactSQL_h
#define ContactSQL_h
#define     CONTACT_TABLE_NAME              @"contact"

/*
 * id 主键
 * userId
 * username 用户名称
 * wechatId 微信id
 * avatarPath 头像路径
 * phone 手机号
 */
#define     SQL_CREATE_CONTACT_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\
                                                userId TEXT NOT NULL DEFAULT '',\
                                                username TEXT NOT NULL DEFAULT '',\
                                                wechatId TEXT NOT NULL DEFAULT '',\
                                                avatarPath TEXT NOT NULL DEFAULT '',\
                                                phone TEXT NOT NULL DEFAULT '')"


#define     SQL_ADD_CONTACT                 @"INSERT INTO %@ (userId, username, wechatId, avatarPath, phone) VALUES ( ?, ?, ?, ?, ?)"
#define     SQL_SELECT_CONTACT              @"SELECT * FROM %@"
#define     SQL_SELECT_CONTACT_INFO         @"SELECT * FROM %@ where userId = %@"
#endif /* ContactSQL_h */
