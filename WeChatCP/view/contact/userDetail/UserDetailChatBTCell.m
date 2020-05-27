//
//  UserDetailChatBTCell.m
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "UserDetailChatBTCell.h"
#import <Masonry/Masonry.h>

@implementation UserDetailChatBTCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_initView];
    }
    return self;
}

- (void)p_initView
{
    self.button = [[UIButton alloc] init];
    [self.button setTitle:@"发消息" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor greenColor]];
    [self.button setTintColor:[UIColor whiteColor]];
    [self.button.layer setCornerRadius:5];
    [self.button.layer setBorderWidth:1];
    [self.button.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.contentView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-15);
    }];
}


@end
