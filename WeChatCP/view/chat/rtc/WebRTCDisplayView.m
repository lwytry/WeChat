//
//  WebRTCDisplayView.m
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WebRTCDisplayView.h"
#import "Macro.h"
#import <Masonry/Masonry.h>

@interface WebRTCDisplayView ()

@end

@implementation WebRTCDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.screenWidth = CGRectGetWidth(self.frame);
        self.screenHeight = CGRectGetHeight(self.frame) - SAFEAREA_INSETS_BOTTOM;
        self.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        // QNRTCEngine 初始化
        self.rtcEngine = [[QNRTCEngine alloc] init];
        // 设置本地预览视图
        self.rtcEngine.previewView.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
        
        [self addSubview:_rtcEngine.previewView];
    }
    return self;
}

- (void)loadViewCall
{
    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatDF"]];
    avatarImageView.layer.masksToBounds= YES;
    avatarImageView.layer.cornerRadius = 5.0f;
    [self addSubview:avatarImageView];
    self.avatarImageView = avatarImageView;
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(-100);
    }];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    [userNameLabel setText:self.userName];
    [userNameLabel setTextColor:[UIColor whiteColor]];
    [userNameLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [self addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(avatarImageView);
        make.top.mas_equalTo(avatarImageView.mas_bottom).mas_offset(20);
    }];
    
    UIButton *closeButton = [[UIButton alloc] init];
    [self addSubview:closeButton];
    self.closeButton = closeButton;
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(80);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.screenHeight - 180);
        make.left.mas_equalTo(self.mas_left).mas_offset(self.screenWidth/2 - 40);
    }];
    [closeButton setImage:[UIImage imageNamed:@"close-phone"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePublishAndBack:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *label = [[UILabel alloc] init];
    [label setText:@"取消"];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeButton.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(closeButton);
    }];
}

- (void)loadViewAnswer
{
    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatDF"]];
    [self addSubview:avatarImageView];
    self.avatarImageView = avatarImageView;
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(60);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.top.mas_equalTo(self).mas_offset(40);
    }];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    [userNameLabel setText:self.userName];
    [userNameLabel setTextColor:[UIColor whiteColor]];
    [userNameLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [self addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(avatarImageView);
        make.right.mas_equalTo(avatarImageView.mas_left).mas_offset(-20);
    }];
    
    UIButton *closeButton = [[UIButton alloc] init];
    [self addSubview:closeButton];
    self.closeButton = closeButton;
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(80);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.screenHeight - 180);
        make.left.mas_equalTo(self.mas_left).mas_offset(self.screenWidth/4).mas_offset(40);
    }];
    [closeButton setImage:[UIImage imageNamed:@"close-phone"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePublishAndBack:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *closeLabel = [[UILabel alloc] init];
    [closeLabel setText:@"拒绝"];
    [closeLabel setTextColor:[UIColor whiteColor]];
    [closeLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:closeLabel];
    self.closeLabel = closeLabel;
    [closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(closeButton.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(closeButton);
    }];
    
    UIButton *acceptButton = [[UIButton alloc] init];
    [self addSubview:acceptButton];
    self.acceptButton = acceptButton;
    [acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(60);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.screenHeight - 180);
        make.right.mas_equalTo(self.mas_right).mas_offset(self.screenWidth/4).mas_equalTo(-40);
    }];
    acceptButton.layer.masksToBounds= YES;
    acceptButton.layer.cornerRadius = 30.0f;
    acceptButton.backgroundColor = [UIColor greenColor];
    [acceptButton setImage:[UIImage imageNamed:@"video-close"] forState:UIControlStateNormal];
    [acceptButton addTarget:self action:@selector(acceptButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *acceptLabel = [[UILabel alloc] init];
    [self addSubview:acceptLabel];
    self.acceptLabel = acceptLabel;
    [acceptLabel setText:@"接听"];
    [acceptLabel setTextColor:[UIColor whiteColor]];
    [acceptLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [acceptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(acceptButton.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(acceptButton);
    }];
}

- (void)updateView
{
    [self.acceptButton removeFromSuperview];
    [self.acceptLabel removeFromSuperview];
    [self.avatarImageView removeFromSuperview];
    [self.userNameLabel removeFromSuperview];
    
    [self.closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
    }];
    
    [self.closeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
    }];
    [self.closeLabel setText:@"挂断"];
    
    UIButton *microphoneButton = [[UIButton alloc] init];
    [self addSubview:microphoneButton];
    microphoneButton.enabled = YES;
    [microphoneButton setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateSelected];
    [microphoneButton setImage:[UIImage imageNamed:@"microphone-disable"] forState:UIControlStateNormal];
    [microphoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.right.mas_equalTo(self.closeButton.mas_left).mas_offset(-40);
        make.centerY.mas_equalTo(self.closeButton);
    }];
    [microphoneButton addTarget:self action:@selector(microphoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.microphoneButton = microphoneButton;


    UIButton *cameraButton = [[UIButton alloc] init];
    [self addSubview:cameraButton];
    [cameraButton setImage:[UIImage imageNamed:@"camera-front"] forState:UIControlStateNormal];
    [cameraButton setImage:[UIImage imageNamed:@"camera-back"] forState:UIControlStateSelected];
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.left.mas_equalTo(self.closeButton.mas_right).mas_offset(40);
        make.centerY.mas_equalTo(self.closeButton);
    }];
    [cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cameraButton = cameraButton;
    [self.superview layoutIfNeeded];
}

- (void)closePublishAndBack:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCloseButton:)]) {
        [self.delegate clickCloseButton:button];
    }
}

- (void)acceptButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickAcceptButton:)]) {
        [self.delegate clickAcceptButton:button];
    }
}

- (void)videoButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickVideoButton:)]) {
        [self.delegate clickVideoButton:button];
    }
}

- (void)microphoneButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMicrophoneButton:)]) {
        [self.delegate clickMicrophoneButton:button];
    }
}

- (void)cameraButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCameraButton:)]) {
        [self.delegate clickCameraButton:button];
    }
}

@end
