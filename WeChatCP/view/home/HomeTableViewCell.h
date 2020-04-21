//
//  HomeTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
/**
 *  model
 */
@property (nonatomic, strong) Person *userInfo;

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
- (void)setUserInfo:(Person * _Nonnull)userInfo;
@end

NS_ASSUME_NONNULL_END
