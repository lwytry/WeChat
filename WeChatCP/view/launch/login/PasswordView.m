//
//  PasswordView.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "PasswordView.h"
@implementation PasswordView

+ (instancetype)passwordView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}
@end
