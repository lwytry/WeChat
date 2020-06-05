//
//  WebRTCDisplayView.h
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebTRCDisplayDelegate.h"
#import <QNRTCKit/QNRTCKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebRTCDisplayView : UIView

@property (nonatomic, assign) id <WebTRCDisplayDelegate> delegate;

@property (nonatomic, strong) QNRTCEngine *rtcEngine;

@property (nonatomic, assign) CGFloat screenWidth;

@property (nonatomic, assign) CGFloat screenHeight;

@property (nonatomic, strong) NSString *userAvatar;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UILabel *closeLabel;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UIButton *acceptButton;

@property (nonatomic, strong) UILabel *acceptLabel;

@property (nonatomic, strong) UIButton *microphoneButton;

@property (nonatomic, strong) UIButton *cameraButton;

// 可以吧 这个部分提出来

- (void)loadViewCall;

- (void)loadViewAnswer;

- (void)updateView;

@end

NS_ASSUME_NONNULL_END
