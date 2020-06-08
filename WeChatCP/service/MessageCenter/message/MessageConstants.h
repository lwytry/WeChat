//
//  MessageConstants.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//
#import "Macro.h"
#ifndef MessageConstants_h
#define MessageConstants_h

/**
 *  消息所有者类型
 */
typedef NS_ENUM(NSInteger, PartnerType){
    PartnerTypeUser,          // 用户
    PartnerTypeGroup,         // 群聊
};

/**
 *  消息拥有者
 */
typedef NS_ENUM(NSInteger, MessageOwnerType){
    MessageOwnerTypeUnknown,  // 未知的消息拥有者
    MessageOwnerTypeSystem,   // 系统消息
    MessageOwnerTypeSelf,     // 自己发送的消息
    MessageOwnerTypeFriend,   // 接收到的他人消息
};

/**
 *  消息发送状态
 */
typedef NS_ENUM(NSInteger, MessageSendState){
    MessageSendSuccess,       // 消息发送成功
    MessageSendFail,          // 消息发送失败
    MessageSendRecall         // 撤回
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSInteger, MessageReadState) {
    MessageUnRead,            // 消息未读
    MessageReaded,            // 消息已读
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeUnknown,
    MessageTypeText,          // 文字
    MessageTypeImage,         // 图片
    MessageTypeExpression,    // 表情
    MessageTypeVoice,         // 语音
    MessageTypeVideo,         // 视频
    MessageTypeWebRTC,        // 实时音视频
    MessageTypeURL,           // 链接
    MessageTypePosition,      // 位置
    MessageTypeBusinessCard,  // 名片
    MessageTypeSystem,        // 系统
    MessageTypeOther,
};


#define     MAX_MESSAGE_WIDTH               SCREEN_WIDTH * 0.58
#define     MAX_MESSAGE_IMAGE_WIDTH         SCREEN_WIDTH * 0.45
#define     MIN_MESSAGE_IMAGE_WIDTH         SCREEN_WIDTH * 0.25
#define     MAX_MESSAGE_EXPRESSION_WIDTH    SCREEN_WIDTH * 0.35
#define     MIN_MESSAGE_EXPRESSION_WIDTH    SCREEN_WIDTH * 0.2


#endif /* MessageConstants_h */
