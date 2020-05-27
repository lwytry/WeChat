//
//  MessageBaseCellTableViewCell.m
//  WeChatCP
//
//  Created by lwy on 2020/5/7.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageBaseCell.h"
#import <Masonry/Masonry.h>
#import "NSDate+Chat.h"
#import "Macro.h"

#define     TIMELABEL_HEIGHT    20.0f
#define     TIMELABEL_SPACE_Y   10.0f

#define     NAMELABEL_HEIGHT    14.0f
#define     NAMELABEL_SPACE_X   12.0f
#define     NAMELABEL_SPACE_Y   1.0f

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      12.0f

#define     MSGBG_SPACE_X       5.0f
#define     MSGBG_SPACE_Y       1.0f

@interface MessageBaseCell ()

@end

@implementation MessageBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.avatarButton];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.messageBackgroundView];
        [self p_addMasonry];
    }
    
    return self;
}

- (void)setMessage:(Message *)message
{
    if (_message && (_message.ID == message.ID)) {
        return;
    }
    [self.timeLabel setText:[NSString stringWithFormat:@" %@ ", message.date]];
    [self.usernameLabel setText:[message.fromUser chat_username]];
    if ([message.fromUser chat_avatarURL].length > 0) {
        // 网络读取图片
        [self.avatarButton setImage:[UIImage imageNamed:[message.fromUser chat_avatarURL]] forState:UIControlStateNormal];
    } else {
        [self.avatarButton setImage:[UIImage imageNamed:[message.fromUser chat_avatarURL]] forState:UIControlStateNormal];
    }
    
    // 时间
    if (!_message || _message.showTime != message.showTime) {
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(message.showTime ? TIMELABEL_HEIGHT : 0);
            make.top.mas_equalTo(self.contentView).mas_offset(message.showTime ? TIMELABEL_SPACE_Y : 0);
        }];
    }
    
    if ( !message || _message.ownerTyper != message.ownerTyper) {
        // 头像
        [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(AVATAR_WIDTH);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
            if(message.ownerTyper == MessageOwnerTypeSelf) {
                make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
            }
            else {
                make.left.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_X);
            }
        }];
        
        // 用户名
        [self.usernameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
            if (message.ownerTyper == MessageOwnerTypeSelf) {
                make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
            }
            else {
                make.left.mas_equalTo(self.avatarButton.mas_right).mas_equalTo(NAMELABEL_SPACE_X);
            }
        }];
        
        // 背景
        [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            message.ownerTyper == MessageOwnerTypeSelf ? make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X) : make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSGBG_SPACE_X);
            make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(message.showName ? 0 : -MSGBG_SPACE_Y);
        }];
    }
    [self.usernameLabel setHidden:!message.showName];
    [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(message.showName ? NAMELABEL_HEIGHT : 0);
    }];
    
    _message = message;
}

- (void)updateMessage:(Message *)message
{
    [self setMessage:message];
}

#pragma mark - Event Response -
- (void)avatarButtonDown:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellDidClickAvatarForUser:)]) {
        
    }
}

- (void)longPressMessageBGView:(UIGestureRecognizer *)gestureRecognizer
{
    
}

- (void)doubleTapMessageBGView
{

}

#pragma mark - Getter -
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setBackgroundColor:[UIColor grayColor]];
        [_timeLabel setAlpha:0.7f];
        [_timeLabel.layer setMasksToBounds:YES];
        [_timeLabel.layer setCornerRadius:5.0f];
    }
    return _timeLabel;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_avatarButton.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
        [_avatarButton addTarget:self action:@selector(avatarButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarButton;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor grayColor]];
        [_usernameLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _usernameLabel;
}

- (UIImageView *)messageBackgroundView
{
    if (_messageBackgroundView == nil) {
        _messageBackgroundView = [[UIImageView alloc] init];
        [_messageBackgroundView setUserInteractionEnabled:YES];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMessageBGView:)];
        [_messageBackgroundView addGestureRecognizer:longPressGesture];
        
        UITapGestureRecognizer *doubleTapCesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapMessageBGView)];
        [doubleTapCesture setNumberOfTapsRequired:2];
        [_messageBackgroundView addGestureRecognizer:doubleTapCesture];
    }
    return _messageBackgroundView;
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(TIMELABEL_SPACE_Y);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
    }];
    
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
    }];
    
    [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(-MSGBG_SPACE_Y);
    }];
}

@end
