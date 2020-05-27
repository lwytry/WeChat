//
//  LaunchManager.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LaunchManager : NSObject

// 当前根控制器
@property (nonatomic, strong, readonly) __kindof UIViewController *curRootVC;

// 根tabbarcontroller
@property (nonatomic, strong, readonly) RootTabBarController *tabBarController;

+ (LaunchManager *)sharedInstance;

- (void)launchInWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
