//
//  Macro.h
//  WeChatCP
//
//  Created by lwy on 2020/4/29.
//  Copyright © 2020 lwy. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define     HEIGHT_CHATBAR_TEXTVIEW         36.0f
#define     HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f
#define     HEIGHT_CHAT_KEYBOARD            215.0f

#pragma mark - chat // 重置聊天窗口
#define     NOTI_CHAT_VIEW_RESET            @"NT_ResetChatView"

#pragma mark - chat NS_ENUM
typedef NS_ENUM(NSInteger, ChatBarState) {
    ChatBarStateInit,
    ChatBarStateVoice,
    ChatBarStateEmoji,
    ChatBarStateMore,
    ChatBarStateKeyboard,
};

#pragma mark - # 屏幕尺寸
#define     SCREEN_SIZE                 [UIScreen mainScreen].bounds.size
#define     SCREEN_WIDTH                SCREEN_SIZE.width
#define     SCREEN_HEIGHT               SCREEN_SIZE.height

#pragma mark - # 常用控件高度
#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     SAFEAREA_INSETS     \
({   \
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero; \
    if (@available(iOS 11.0, *)) {      \
        edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;     \
    }   \
    edgeInsets;  \
})\

#define     SAFEAREA_INSETS_BOTTOM      (SAFEAREA_INSETS.bottom)

#define FILE_SERVER_DOMAIN_NAME @"/Users/lwy/www/file/"
#endif /* Macro_h */
