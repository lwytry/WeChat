//
//  MyAppDelegate.m
//  WeChatCP
//
//  Created by lwy on 2020/4/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MyAppDelegate.h"
#import "RootTabBarController.h"
#import "BootLoginViewController.h"
#import "MessageManager.h"
#import "UserHelper.h"
#import "LaunchManager.h"

@interface MyAppDelegate()
@property (nonatomic, strong) UIViewController *rootVC;
@end
@implementation MyAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    NSString *homePath = NSHomeDirectory();
    NSLog(@"home根目录:%@", homePath);

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[LaunchManager sharedInstance] launchInWindow:self.window];
    [self changeNav];
    return YES;
}

// 进入活动状态
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

// 进入非活动状态
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

// 进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

// 终止
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[MessageManager sharedInstance] closeWebSocekt];
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
