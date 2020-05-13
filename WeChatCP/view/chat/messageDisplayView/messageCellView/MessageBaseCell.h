//
//  MessageBaseCellTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/5/7.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCellDelegate.h"
#import "Message.h"
#import "Macro.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageBaseCell : UITableViewCell

@property (nonatomic, assign) id<MessageCellDelegate>delegate;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *avatarButton;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UIImageView *messageBackgroundView;

@property (nonatomic, strong) Message *message;

/*
    更新消息, 如果子类不重写, 默认调用setMessage
 */
- (void)updateMessage:(Message *)message;

@end

NS_ASSUME_NONNULL_END
