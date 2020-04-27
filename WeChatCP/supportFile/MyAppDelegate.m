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

@interface MyAppDelegate()
@property (nonatomic, strong) UIViewController *rootVC;
@end
@implementation MyAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *phone = [userDefault objectForKey:@"phone"];
    if (phone) {
        self.rootVC = [[RootTabBarController alloc]init];
    } else {
        self.rootVC = [[BootLoginViewController alloc] init];
    }
    self.window.rootViewController = self.rootVC;
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
