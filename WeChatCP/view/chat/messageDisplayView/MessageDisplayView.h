//
//  MessageDisplayView.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDisplayViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageDisplayView : UIView

@property (nonatomic, assign) id<MessageDisplayViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong, readonly) UITableView *tabView;

@property (nonatomic, assign) BOOL disablePullToRefresh;

@property (nonatomic, assign) BOOL disableLoginPressMenu;

@property (nonatomic, strong) UIView *menuView;

/*
    发送消息
 */
- (void)sendMessage:(UIView *)message;

/**
    删除消息
*/
- (void)deleteMessage:(UIView *)message;
- (void)deleteMessage:(UIView *)message withAnimation:(BOOL)animation;

/*
    更新消息
 */
- (void)updateMessage:(UIView *)message;
- (void)reloadData;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

/**
 *  重新加载聊天信息
 */
- (void)resetMessageView;

@end

NS_ASSUME_NONNULL_END
