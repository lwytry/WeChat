//
//  UIColor+Chat.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Chat)
#pragma mark - # 字体
+ (UIColor *)colorTextBlack;
+ (UIColor *)colorTextGray;
+ (UIColor *)colorTextGray1;


#pragma mark - 灰色
+ (UIColor *)colorGrayBG;           // 浅灰色默认背景
+ (UIColor *)colorGrayCharcoalBG;   // 较深灰色背景（聊天窗口, 朋友圈用）
+ (UIColor *)colorGrayLine;
+ (UIColor *)colorGrayForChatBar;
+ (UIColor *)colorGrayForMoment;



#pragma mark - 绿色
+ (UIColor *)colorGreenDefault;
+ (UIColor *)colorGreenHL;


#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment;


#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar;
+ (UIColor *)colorBlackBG;
+ (UIColor *)colorBlackAlphaScannerBG;
+ (UIColor *)colorBlackForAddMenu;
+ (UIColor *)colorBlackForAddMenuHL;

#pragma mark - 红色
+ (UIColor *)colorRedForButton;
+ (UIColor *)colorRedForButtonHL;
@end

NS_ASSUME_NONNULL_END
