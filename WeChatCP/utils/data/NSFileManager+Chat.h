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

// 区分目录的原因用来 查找和删除图片便利
/**
 *  图片 — 聊天
 */
+ (NSString *)pathUserChatImage:(NSString*)imageName dstId:(NSString *)dstId;

+ (NSString *)pathUserChatImageForOss:(NSString*)imageName dstId:(NSString *)dstId;

+ (NSString *)pathPartnerImageForOss:(NSString*)imageName dstId:(NSString *)dstId;

/**
 *  视频 — 聊天
 */
+ (NSString *)pathUserChatVideoImage:(NSString*)imageName dstId:(NSString *)dstId;

+ (NSString *)pathUserChatVideo:(NSString*)videoName dstId:(NSString *)dstId;

+ (NSString *)pathUserChatVideoImageForOss:(NSString*)imageName dstId:(NSString *)dstId;

+ (NSString *)pathUserChatVideoForOss:(NSString*)videoName dstId:(NSString *)dstId;

+ (NSString *)pathPartnerVideoImageForOss:(NSString*)imageName dstId:(NSString *)dstId;

+ (NSString *)pathPartnerVideoForOss:(NSString*)videoName dstId:(NSString *)dstId;


@end

NS_ASSUME_NONNULL_END
