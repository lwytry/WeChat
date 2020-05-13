//
//  MessageCellDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/5/7.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatUserProtocol;

@class Message;

NS_ASSUME_NONNULL_BEGIN

@protocol MessageCellDelegate <NSObject>

- (void)messageCellDidClickAvatarForUser:(id<ChatUserProtocol>)user;

- (void)messageCellTap:(Message *)message;

- (void)messageLongPress:(Message *)message rect:(CGRect)rect;

- (void)messageCellDoubleClick:(Message *)message;


@end

NS_ASSUME_NONNULL_END
