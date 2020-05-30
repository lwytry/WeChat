//
//  UIColor+Chat.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "UIColor+Chat.h"

@implementation UIColor (Chat)
+ (UIColor *)RGBAColor:(float)r g:(float)g b:(float)b a:(float)a
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a];
}
#pragma mark - # 字体
+ (UIColor *)colorTextBlack {
    return [UIColor blackColor];
}

+ (UIColor *)colorTextGray {
    return [UIColor grayColor];
}

+ (UIColor *)colorTextGray1 {
    return [self RGBAColor:160 g:160 b:160 a:1.0];
}

#pragma mark - 灰色
+ (UIColor *)colorGrayBG {
    return [self RGBAColor:239.0 g:239.0 b:244.0 a:1.0];
}

+ (UIColor *)colorGrayCharcoalBG {
    return [self RGBAColor:235.0 g:235.0 b:235.0 a:1.0];
}

+ (UIColor *)colorGrayLine {
    return [UIColor colorWithWhite:0.5 alpha:0.3];
}

+ (UIColor *)colorGrayForChatBar {
    return [self RGBAColor:245.0 g:245.0 b:247.0 a:1.0];
}

+ (UIColor *)colorGrayForMoment {
    return [self RGBAColor:243.0 g:243.0 b:245.0 a:1.0];
}




#pragma mark - 绿色
+ (UIColor *)colorGreenDefault {
    return [self RGBAColor:2.0 g:187.0 b:0.0 a:1.0];
}

+ (UIColor *)colorGreenHL {
    return [self RGBAColor:46 g:139 b:46 a:1.0];
}

#pragma mark - 蓝色
+ (UIColor *)colorBlueMoment {
    return [self RGBAColor:74.0 g:99.0 b:141.0 a:1.0];
}

#pragma mark - 黑色
+ (UIColor *)colorBlackForNavBar {
    return [self RGBAColor:20.0 g:20.0 b:20.0 a:1.0];
}

+ (UIColor *)colorBlackBG {
    return [self RGBAColor:46.0 g:49.0 b:50.0 a:1.0];
}

+ (UIColor *)colorBlackAlphaScannerBG {
    return [UIColor colorWithWhite:0 alpha:0.6];
}

+ (UIColor *)colorBlackForAddMenu {
    return [self RGBAColor:71 g:70 b:73 a:1.0];
}

+ (UIColor *)colorBlackForAddMenuHL {
    return [self RGBAColor:65 g:64 b:67 a:1.0];
}


#pragma mark - # 红色
+ (UIColor *)colorRedForButton {
    return [self RGBAColor:228 g:68 b:71 a:1.0];
}

+ (UIColor *)colorRedForButtonHL {
    return [self RGBAColor:205 g:62 b:64 a:1.0];
}
@end
