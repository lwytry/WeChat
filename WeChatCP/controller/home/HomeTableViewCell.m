//
//  HomeTableViewCell.m
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "HomeTableViewCell.h"
#import <Masonry.h>
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUserInfo:(User *)userInfo
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.avatarImageView.image = [UIImage imageNamed:userInfo.avatarPath];
    self.nameLabel.text = userInfo.userName;
    self.wechatIdLabel.text = [NSString stringWithFormat:@"微信号: %@", userInfo.wechatId];
    self.barcodeImageView.image = [UIImage imageNamed:@"mine_cell_myQR"];
    self.barcodeImageView.backgroundColor = [UIColor whiteColor];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initView];
    }
    return self;
}
- (void)p_initView
{
    UIImageView *headImg = [UIImageView new];
    headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:headImg];
    self.avatarImageView = headImg;
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.0f);
        make.top.mas_equalTo(12.0f);
        make.size.mas_equalTo(70.0f);
    }];
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:21.0f];
    [self.contentView addSubview:nameLabel];
    [self.nameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    
    self.nameLabel = nameLabel;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(12.0f);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-10);
    }];
    UILabel *wechatIdLabel = [UILabel new];
    wechatIdLabel.font = [UIFont systemFontOfSize:12.5f];
    wechatIdLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:wechatIdLabel];
    self.wechatIdLabel = wechatIdLabel;
    [self.wechatIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(5.0);
    }];
//
    UIImageView *barcodeImageView = [UIImageView new];
    [self.contentView addSubview:barcodeImageView];
    self.barcodeImageView = barcodeImageView;
    [self.contentView addSubview:barcodeImageView];
    [self.barcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.wechatIdLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView).mas_offset(-50);
        make.height.and.width.mas_equalTo(18);
    }];
}
@end
