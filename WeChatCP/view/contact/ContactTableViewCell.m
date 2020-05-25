//
//  ContactTableViewCell.m
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ContactTableViewCell.h"
#import <Masonry/Masonry.h>
//static NSInteger const kContentInsetH = 10;
//static NSInteger const kContentInsetV = 6;

@interface ContactTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(User *)user
{
    self.avatarImageView.image = [UIImage imageNamed:user.avatarURL];
    self.nameLabel.text = user.userName;
}

#pragma mark - # Prvate Methods
- (void)p_initView
{
    self.avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
}
@end
