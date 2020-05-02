//
//  HomeTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
/**
 *  model
 */
@property (nonatomic, strong) User *userInfo;

/**
 *  用户头像ImgView
 */
@property (nonatomic, strong) UIImageView* avatarImageView;

/**
 *  用户名Label
 */
@property (nonatomic, strong) UILabel* nameLabel;

/**
 *  微信号Label
 */
@property (nonatomic, strong) UILabel* wechatIdLabel;

/**
 *  二维码ImgView
 */
@property (nonatomic, strong) UIImageView* barcodeImageView;
- (void)setUserInfo:(User * _Nonnull)userInfo;
@end

NS_ASSUME_NONNULL_END
