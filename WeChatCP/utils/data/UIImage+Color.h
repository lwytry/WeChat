//
//  UIImage+Color.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithColor:(UIColor *)color;

// 灰色图像
- (UIImage *)grayImage;
@end

NS_ASSUME_NONNULL_END
