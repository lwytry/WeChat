//
//  MyAppDelegate.m
//  WeChatCP
//
//  Created by lwy on 2020/4/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MyAppDelegate.h"
#import "RootTabBarController.h"
@interface MyAppDelegate()

@end
@implementation MyAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[RootTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    [self changeNav];
    return YES;
}

- (void)changeNav
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:54 / 255.0
    green:53 / 255.0
     blue:58 / 255.0
    alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    }];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}

@end
