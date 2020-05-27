//
//  UserDetailInfoCell.h
//  WeChatCP
//
//  Created by lwy on 2020/5/25.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserDetailInfoCell : UICollectionViewCell

@property (nonatomic, strong)User *userModel;

- (void)setModel:(User *)user;

@end

NS_ASSUME_NONNULL_END
