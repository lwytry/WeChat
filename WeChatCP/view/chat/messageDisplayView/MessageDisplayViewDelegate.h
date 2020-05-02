//
//  MessageDisplayViewDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageDisplayView;
@protocol MessageDisplayViewDelegate <NSObject>

// 聊天界面被点击, 用于收键盘
- (void)chatMessageDisplayViewDidTouched:(MessageDisplayView *)chatTouchView;

@end

