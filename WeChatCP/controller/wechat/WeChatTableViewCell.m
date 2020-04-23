//
//  WeChatTableViewCell.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WeChatTableViewCell.h"
#import "WeChat.h"
#import <Masonry/Masonry.h>
@implementation WeChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initView];
    }
    return self;
}
- (void) configCell:(WeChat *)wechat
{
    self.imgView.image = [UIImage imageNamed:wechat.picName];
    self.imgView.layer.cornerRadius = 8;
    self.imgView.layer.masksToBounds = YES;
    self.titleLabel.text = wechat.titleText;
    self.timeLabel.text = wechat.timeText;
    self.contentLabel.text = wechat.contentText;
}
- (void)p_initView
{
    UIImageView *headImg = [UIImageView new];
    [self.contentView addSubview:headImg];
    self.imgView = headImg;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(48);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *timelabel = [UILabel new];
    timelabel.font = [UIFont systemFontOfSize:12.5f];
    timelabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:timelabel];
    self.timeLabel = timelabel;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView);
        make.right.mas_equalTo(self.contentView).mas_offset(-10.0);
    }];
    
    UILabel *titlelabel = [UILabel new];
    titlelabel.font = [UIFont systemFontOfSize:17.0f];
    [self.contentView addSubview:titlelabel];
    self.titleLabel = titlelabel;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.imgView);
        make.right.mas_lessThanOrEqualTo(self.timeLabel.mas_left).mas_offset(-10);
    }];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:14.0f];
    detailLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self.contentView addSubview:detailLabel];
    self.contentLabel = detailLabel;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-10);
    }];
}
@end
