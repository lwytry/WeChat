//
//  UserDetailInfoCell.m
//  WeChatCP
//
//  Created by lwy on 2020/5/25.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "UserDetailInfoCell.h"
#import <Masonry/Masonry.h>

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface UserDetailInfoCell ()

@property (nonatomic, strong) UIButton *avatarButtonView;

@property (nonatomic, strong) UILabel *shownNameLabel;

@property (nonatomic, strong) UILabel *wechatIdLabel;

@property (nonatomic, strong) UILabel *userNameLabel;

@end

@implementation UserDetailInfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_initView];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setModel:(User *)user
{
    [self.avatarButtonView setImage:[UIImage imageNamed:user.avatarURL] forState:UIControlStateNormal];
    self.shownNameLabel.text = user.userName;
    self.wechatIdLabel.text = [NSString stringWithFormat:@"微信号: %@", user.wechatId];
    self.userNameLabel.text = [NSString stringWithFormat:@"昵称: %@", user.userName];
}

- (void)p_initView
{
    self.avatarButtonView = [[UIButton alloc] init];
    [self.contentView addSubview:self.avatarButtonView];
    [self.avatarButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(14);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-12);
        make.width.mas_equalTo(self.avatarButtonView.mas_height);
    }];

    self.shownNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.shownNameLabel];
    [self.shownNameLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [self.shownNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarButtonView.mas_right).mas_offset(MINE_SPACE_Y);
        make.top.mas_equalTo(self.avatarButtonView.mas_top).mas_offset(3);
    }];

    self.wechatIdLabel = [[UILabel alloc] init];
    [self.wechatIdLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.wechatIdLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:self.wechatIdLabel];
    [self.wechatIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownNameLabel);
        make.top.mas_equalTo(self.shownNameLabel.mas_bottom).mas_offset(5);
    }];

    self.userNameLabel = [[UILabel alloc] init];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.userNameLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownNameLabel);
        make.top.mas_equalTo(self.wechatIdLabel.mas_bottom).mas_offset(3);
    }];
}

@end
