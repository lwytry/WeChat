//
//  BaseKeyboard.h
//  WeChatCP
//
//  Created by lwy on 2020/5/1.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardDelegate.h"
#import "KeyboardProtocol.h"

@interface BaseKeyboard : UIView <KeyboardProtocol>

@property (nonatomic, assign, readonly) BOOL isShow;

@property (nonatomic, weak) id<KeyboardDelegate> keyboardDelegate;

/**
 *  显示键盘(在keyWindow上)
 *
 *  @param animation 是否显示动画
 */
- (void)showWithAnimation:(BOOL)animation;

/**
 *  显示键盘
 *
 *  @param view      父view
 *  @param animation 是否显示动画
 */
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

/**
 *  键盘消失
 *
 *  @param animation 是否显示消失动画
 */
- (void)dismissWithAnimation:(BOOL)animation;

/**
 *  重置键盘
 */
- (void)reset;

@end
