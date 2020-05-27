//
//  LaunchManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "LaunchManager.h"
#import "UserHelper.h"
#import "MessageManager.h"
#import "ConversationController.h"
#import "ContactViewController.h"
#import "DiscoverViewController.h"
#import "HomeViewController.h"
#import "BootLoginViewController.h"

@interface LaunchManager()

@property (nonatomic, weak)UIWindow *window;

@end

@implementation LaunchManager
@synthesize tabBarController = _tabBarController;

+ (LaunchManager *)sharedInstance
{
    static LaunchManager *rootVCManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootVCManager = [[self alloc] init];
    });
    return rootVCManager;
}

- (void)launchInWindow:(UIWindow *)window
{
    _window = window;
    if ([UserHelper sharedHelper].isLogin) {
        [self.tabBarController setViewControllers:[self p_createTabBarChildViewController]];
        [self setCurRootVC:self.tabBarController];
        [[MessageManager sharedInstance] createWebSocekt];
    } else {
        [self setCurRootVC:[[BootLoginViewController alloc] init]];
    }
}

- (NSArray *)p_createTabBarChildViewController
{
    ConversationController *wechatVC = [[ConversationController alloc] init];
    ContactViewController *contactVC = [[ContactViewController alloc] init];
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    NSArray *data = @[
        [self addNavigationController:wechatVC],
        [self addNavigationController:contactVC],
        [self addNavigationController:discoverVC],
        [self addNavigationController:homeVC],
    ];
    return data;
}

- (UINavigationController *)addNavigationController:(UIViewController *)viewController
{
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    return naVC;
}

- (void)setCurRootVC:(__kindof UIViewController *)curRootVC
{
    _curRootVC = curRootVC;
    UIWindow *window = self.window ? self.window : [UIApplication sharedApplication].keyWindow;
    [window removeFromSuperview];
    [window setRootViewController:curRootVC];
    [window makeKeyAndVisible];
}

- (RootTabBarController *)tabBarController
{
    if (!_tabBarController) {
        RootTabBarController *tabBarController = [[RootTabBarController alloc] init];
        [tabBarController.tabBar setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]];
        [tabBarController.tabBar setTintColor:[UIColor greenColor]];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

@end
