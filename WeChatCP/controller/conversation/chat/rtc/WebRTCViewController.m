//
//  WebRTCViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/5/28.
//  Copyright © 2020 lwy. All rights reserved.
//


#import "WebRTCViewController.h"
#import <QNRTCKit/QNRTCKit.h>
#import "Macro.h"
#import "WebRTCDisplayView.h"
#import <Masonry/Masonry.h>
#import "ChatUserProtocol.h"
#import "SoundHelpler.h"
#import "WebRTCMessage.h"


@interface WebRTCViewController () <QNRTCEngineDelegate, WebTRCDisplayDelegate>

@property (nonatomic, strong) WebRTCMessage *message;

@property (nonatomic, assign) CGFloat screenWidth;

@property (nonatomic, assign) CGFloat screenHeight;

@property (nonatomic, strong) NSDictionary *settingsDic;

@property (nonatomic, assign) CGSize videoEncodeSize;
@property (nonatomic, assign) NSInteger bitrate;

@property (nonatomic, strong) QNRTCEngine *rtcEngine;

@property (nonatomic, strong) QNTrackInfo *audioTrackInfo;

@property (nonatomic, strong) QNTrackInfo *cameraTrackInfo;

@property (nonatomic, strong) WebRTCDisplayView *webRTCView;

@end

@implementation WebRTCViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (id)initWithMessage:(id)message
{
    if (self = [super init]) {
        _message = message;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenWidth = CGRectGetWidth(self.view.frame);
    self.screenHeight = CGRectGetHeight(self.view.frame) - SAFEAREA_INSETS_BOTTOM;
    // 获取 QNRTCKit 的分辨率、帧率、码率的配置
    self.settingsDic = [self settingsArrayAtIndex:1];

    // QNRTCKit 的分辨率
    self.videoEncodeSize = CGSizeFromString(_settingsDic[@"VideoSize"]);
    // QNRTCKit 的码率
    self.bitrate = [self.settingsDic[@"Bitrate"] integerValue];
    
    [self.view addSubview:self.webRTCView];
    
    [SoundHelpler playSoundWithName:@"call.caf"];
    self.rtcEngine = self.webRTCView.rtcEngine;
    [self.webRTCView.rtcEngine setDelegate:self];
    // 设置采集视频的帧率
    self.webRTCView.rtcEngine.videoFrameRate = [self.settingsDic[@"FrameRate"] integerValue];
    if (self.message.ownerTyper == MessageOwnerTypeSelf) {
        [self startRTCEngine];
    }
}

#pragma mark - settings

- (NSDictionary *)settingsArrayAtIndex:(NSInteger)index {
    NSArray *settingsArray = @[@{@"VideoSize":NSStringFromCGSize(CGSizeMake(288, 352)), @"FrameRate":@15, @"Bitrate":@(300*1000)},
                        @{@"VideoSize":NSStringFromCGSize(CGSizeMake(480, 640)), @"FrameRate":@15, @"Bitrate":@(400*1000) },
                        @{@"VideoSize":NSStringFromCGSize(CGSizeMake(544, 960)), @"FrameRate":@15, @"Bitrate":@(700*1000)},
                        @{@"VideoSize":NSStringFromCGSize(CGSizeMake(720, 1280)), @"FrameRate":@20, @"Bitrate":@(1000*1000)}];
    return settingsArray[index];
}

#pragma mark - QNRTCKit 核心类

- (void)startRTCEngine {
    // 开始采集
    [self.webRTCView.rtcEngine startCapture];
    // 加入房间
    [self.webRTCView.rtcEngine joinRoomWithToken:self.token];
}

#pragma mark - QNRTCEngineDelegate 代理回调

/*
 发生错误的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError - %@", error);
    NSArray *errorArray = @[@(QNRTCErrorTokenError),
                            @(QNRTCErrorRoomInstanceClosed),
                            @(QNRTCErrorReconnectTokenError),
                            @(QNRTCErrorPublishStreamNotExist),
                            @(QNRTCErrorSubscribeStreamNotExist),
                            @(QNRTCErrorServerUnavailable),
                            @(QNRTCErrorInvalidParameter)];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([errorArray containsObject:@(error.code)] ) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"error code: %ld error domain: %@", (long)error.code, error.domain] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertVc addAction:sureAction];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
    });
}

/*
 房间内状态变化的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine roomStateDidChange:(QNRoomState)roomState {
    NSDictionary *roomStateDictionary =  @{@(QNRoomStateIdle) : @"Idle",
                                           @(QNRoomStateConnecting) : @"Connecting",
                                           @(QNRoomStateConnected): @"Connected",
                                           @(QNRoomStateReconnecting) : @"Reconnecting",
                                           @(QNRoomStateReconnected) : @"Reconnected"
                                           };
    NSLog(@"roomStateDidChange - %@", roomStateDictionary[@(roomState)]);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (QNRoomStateConnected == roomState) {
            self.webRTCView.microphoneButton.selected = YES;
            // 音频
            QNTrackInfo *audioTrack = [[QNTrackInfo alloc] initWithSourceType:QNRTCSourceTypeAudio master:YES];
            // 视频
            QNTrackInfo *cameraTrack = [[QNTrackInfo alloc] initWithSourceType:QNRTCSourceTypeCamera tag:@"camera" master:YES bitrateBps:self.bitrate videoEncodeSize:self.videoEncodeSize];

            // 发布音视频
            [self.rtcEngine publishTracks:@[audioTrack, cameraTrack]];

        } else if (QNRoomStateIdle == roomState) {
        } else if (QNRoomStateReconnecting == roomState) {
            self.webRTCView.microphoneButton.enabled = NO;
        } else if (QNRoomStateReconnected == roomState) {
            self.webRTCView.microphoneButton.enabled = YES;
        }
    });
}

/*
 发布本地音/视频成功的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didPublishLocalTracks:(NSArray<QNTrackInfo *> *)tracks {
    NSLog(@"didPublishLocalTracks - %@", tracks);
    dispatch_async(dispatch_get_main_queue(), ^{
        for (QNTrackInfo *trackInfo in tracks) {
            if (trackInfo.kind == QNTrackKindAudio) {
                self.webRTCView.microphoneButton.enabled = YES;
                self.audioTrackInfo = trackInfo;
                continue;
            }
            if (trackInfo.kind == QNTrackKindVideo) {
                if ([trackInfo.tag isEqualToString:@"camera"]) {
                    self.cameraTrackInfo = trackInfo;
                }
                continue;
            }
        }
    });
}

/*
 远端用户加入房间的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didJoinOfRemoteUserId:(NSString *)userId userData:(NSString *)userData {
    [SoundHelpler disposeSoundWithName:@"call.caf"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webRTCView updateView];
    });
    NSLog(@"didJoinOfRemoteUserId - userId %@ userData %@", userId, userData);
}

/*
 远端用户发布音/视频的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didPublishTracks:(NSArray<QNTrackInfo *> *)tracks ofRemoteUserId:(NSString *)userId {
    NSLog(@"didPublishTracks - tracks %@ userId %@", tracks, userId);
}

/*
 订阅远端用户成功的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didSubscribeTracks:(NSArray<QNTrackInfo *> *)tracks ofRemoteUserId:(NSString *)userId {
    NSLog(@"didSubscribeTracks - tracks %@ userTd %@", tracks, userId);
}

/*
 远端用户音频状态变更的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didAudioMuted:(BOOL)muted ofTrackId:(NSString *)trackId byRemoteUserId:(NSString *)userId {
    NSLog(@"didAudioMuted - muted %d trackId %@ userId %@", muted, trackId, userId);
}

/*
 远端用户音频状态变更的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didVideoMuted:(BOOL)muted ofTrackId:(nonnull NSString *)trackId byRemoteUserId:(nonnull NSString *)userId {
    NSLog(@"didVideoMuted - muted %d trackId %@ userId %@", muted, trackId, userId);
}

/*
 被踢出房间的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didKickoutByUserId:(NSString *)userId {
    NSLog(@"didKickoutByUserId - %@", userId);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

/*
 远端用户取消发布音/视频的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didUnPublishTracks:(NSArray<QNTrackInfo *> *)tracks ofRemoteUserId:(NSString *)userId {
    NSLog(@"didUnPublishTracks - tracks %@ userId %@", tracks, userId);
}

/*
 远端用户离开房间的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didLeaveOfRemoteUserId:(NSString *)userId {
    NSLog(@"didLeaveOfRemoteUserId - %@", userId);
}

/*
 远端用户首帧解码后的回调（仅在远端用户发布视频时会回调）
 */
- (QNVideoRender *)RTCEngine:(QNRTCEngine *)engine firstVideoDidDecodeOfTrackId:(NSString *)trackId remoteUserId:(NSString *)userId {
    QNVideoRender *render = [[QNVideoRender alloc] init];
    render.renderView = [self remoteUserView:userId];
    return render;
}

/*
 远端用户取消渲染的回调
 */
- (void)RTCEngine:(QNRTCEngine *)engine didDetachRenderView:(UIView *)renderView ofTrackId:(NSString *)trackId remoteUserId:(NSString *)userId {
    NSLog(@"didDetachRenderView - renderview %@ trackId %@ userId %@", renderView, trackId, userId);
    for (UIView *view in self.rtcEngine.previewView.subviews) {
        if ([view isEqual:renderView]) {
            [view removeFromSuperview];
            return;
        }
    }
}

#pragma mark - 远端用户画面

- (QNVideoView *)remoteUserView:(NSString *)userId {
    QNVideoView *remoteView = [[QNVideoView alloc] initWithFrame:CGRectMake(self.screenWidth - self.screenWidth/3, 20, self.screenWidth/3, self.screenWidth/27*16)];
    [self.rtcEngine.previewView addSubview:remoteView];
    
    return remoteView;
}


- (WebRTCDisplayView *)webRTCView
{
    if (_webRTCView == nil) {
        _webRTCView = [[WebRTCDisplayView alloc] initWithFrame:self.view.frame];
        [_webRTCView setDelegate:self];
        _webRTCView.userAvatar = [self.message.fromUser chat_avatarURL];
        _webRTCView.userName = [self.message.fromUser chat_username];
        if (self.message.ownerTyper == MessageOwnerTypeSelf) {
            [_webRTCView loadViewCall];
        } else {
            [_webRTCView loadViewAnswer];
        }
    }
    return _webRTCView;
}
#pragma mark - WebTRCDisplayDelegate

- (void)clickCloseButton:(UIButton *)button
{
    [SoundHelpler disposeSoundWithName:@"call.caf"];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [SoundHelpler playSoundWithName:@"close.wav"];
    });
    [self dismissViewControllerAnimated:YES completion:^{
        [self.rtcEngine leaveRoom];
        [self.rtcEngine stopCapture];
    }];
}

- (void)clickAcceptButton:(UIButton *)button
{
    [self startRTCEngine];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webRTCView updateView];
    });
}

- (void)clickVideoButton:(UIButton *)button
{
    button.selected = !button.isSelected;
    [self.rtcEngine muteVideo:!button.isSelected];
}

- (void)clickMicrophoneButton:(UIButton *)button
{
    NSLog(@"microphoneButtonAction9999999999999999");
    button.selected = !button.isSelected;
    [self.rtcEngine muteAudio:!button.isSelected];
}

- (void)clickCameraButton:(UIButton *)button
{
    button.selected = !button.isSelected;
    [self.rtcEngine toggleCamera];
}

@end
