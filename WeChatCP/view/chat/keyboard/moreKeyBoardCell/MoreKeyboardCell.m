//
//  MoreKeyboardCell.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MoreKeyboardCell.h"
#import "Macro.h"
#import "UIImage+Color.h"
#import <Masonry/Masonry.h>

@interface MoreKeyboardCell()

@property (nonatomic, strong) UIButton *iconButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MoreKeyboardCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconButton];
        [self.contentView addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setItem:(MoreKeyboardItem *)item
{
    _item = item;
    if (item == nil) {
        [self.titleLabel setHidden:YES];
        [self.iconButton setHidden:YES];
        [self setUserInteractionEnabled:NO];
        return;
    }
    
    [self setUserInteractionEnabled:YES];
    [self.titleLabel setHidden:NO];
    [self.iconButton setHidden:NO];
    [self.titleLabel setText:item.title];
    [self.iconButton setImage:[UIImage imageNamed:item.imagePath] forState:UIControlStateNormal];
}

- (void)p_addMasonry
{
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.iconButton.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)iconButtonDown:(UIButton *)sender
{
    self.clickBlock(self.item);
}

- (UIButton *)iconButton
{
    if (_iconButton == nil) {
        _iconButton = [[UIButton alloc] init];
        [_iconButton.layer setMasksToBounds:YES];
        [_iconButton.layer setCornerRadius:5.0f];
        [_iconButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_iconButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [_iconButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.3]] forState:UIControlStateHighlighted];
        [_iconButton addTarget:self action:@selector(iconButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _iconButton;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}

@end
