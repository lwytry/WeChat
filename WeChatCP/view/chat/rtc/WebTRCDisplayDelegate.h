//
//  WebTRCDisplayDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebTRCDisplayDelegate <NSObject>


- (void)clickCloseButton:(UIButton *)button;

- (void)clickAcceptButton:(UIButton *)button;

- (void)clickVideoButton:(UIButton *)button;

- (void)clickMicrophoneButton:(UIButton *)button;

- (void)clickCameraButton:(UIButton *)button;

@end
