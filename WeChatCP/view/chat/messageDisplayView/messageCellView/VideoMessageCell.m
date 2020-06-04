//
//  VideoMessageCell.m
//  WeChatCP
//
//  Created by lwy on 2020/6/3.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "VideoMessageCell.h"
#import "MessageImageView.h"
#import "VideoMessage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSFileManager+Chat.h"

@interface VideoMessageCell ()

@property (nonatomic, strong) MessageImageView *messageImageView;

@property (nonatomic, strong) UIImageView *playView;

@end

@implementation VideoMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.messageImageView];
    }
    
    return self;
}

- (void)setMessage:(VideoMessage *)message
{
    [self.messageImageView setAlpha:1.0];
    if (self.message && [self.message.ID isEqualToNumber:message.ID]) {
        return;
    }
    MessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    if ([message imagePath]) {
        // 从本地读
        NSString *imagePath = [NSFileManager pathUserChatVideoImage:[message imagePath] dstId:message.dstID];
        [self.messageImageView setTumbnailPath:imagePath hightDefinitionImageURL:[message imagePath]];
    } else {
        [self.messageImageView setTumbnailPath:nil hightDefinitionImageURL:[message imageURL]];
        [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:[message imageURL]]];
    }
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == MessageOwnerTypeSelf) {
            [self.messageImageView setBackgroundImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.messageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView);
                make.right.mas_equalTo(self.messageBackgroundView);
            }];
        } else if (message.ownerTyper == MessageOwnerTypeFriend) {
            [self.messageImageView setBackgroundImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.messageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView);
                make.left.mas_equalTo(self.messageBackgroundView);
            }];
        }
    }
    [self.messageImageView addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(40);
        make.center.mas_equalTo(self.messageImageView.center);
    }];
    [self.messageImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
}

#pragma mark - Event Response -
- (void)tapMessageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellTap:)]) {
        [self.delegate messageCellTap:self.message];
    }
}

- (UIImageView *)playView
{
    if (_playView == nil) {
        _playView = [[UIImageView alloc] init];
        _playView.image = [UIImage imageNamed:@"message_video_play"];
    }
    return _playView;
}

- (MessageImageView *)messageImageView
{
    if (_messageImageView == nil) {
        _messageImageView = [[MessageImageView alloc] init];
        [_messageImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMessageView)];
        [_messageImageView addGestureRecognizer:tapGR];
        
    }
    return _messageImageView;
}

@end
