//
//  UserDetailViewController.h
//  WeChatCP
//
//  Created by lwy on 2020/5/25.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
NS_ASSUME_NONNULL_BEGIN

@interface UserDetailViewController : UIViewController

- (instancetype)initWithUserId:(NSString *)userId;

- (instancetype)initWithUserModdel:(User *)userModel;

- (instancetype)init  __attribute__((unavailable("请使用 initWithUserId: 或 initWithUserModel:")));

@end

NS_ASSUME_NONNULL_END
