//
//  NSFileManager+Chat.h
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Chat)

/**
 *  数据库 — 通用
 */
+ (NSString *)pathDBCommon;

/**
 *  数据库 — 聊天
 */
+ (NSString *)pathDBMessage;

@end

NS_ASSUME_NONNULL_END
