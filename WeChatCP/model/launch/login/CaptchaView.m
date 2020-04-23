//
//  CaptchaView.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "CaptchaView.h"

@implementation CaptchaView
+ (instancetype)captchaView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
