//
//  Conversation.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  会话类型
 */
typedef NS_ENUM(NSInteger, ConversationType) {
    ConversationTypePersonal,     // 个人
    ConversationTypeGroup,        // 群聊
};

@interface Conversation : NSObject

/**
 *  会话类型（个人，讨论组，企业号）
 */
@property (nonatomic, assign) ConversationType convType;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *dstID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *dstName;

/**
 *  头像地址（网络）
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 *  消息展示内容
 */
@property (nonatomic, strong) NSString *content;

/**
 *  未读数量
 */
@property (nonatomic, assign) NSInteger unreadCount;

@end
