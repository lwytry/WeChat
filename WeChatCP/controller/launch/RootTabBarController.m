//
//  RootTabBarController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) addChildWithVCName:(NSString *)vcName title:(NSString *)title image:(NSString *)image selectedImg:(NSString *)selectedImg
{
        // 1.创建控制器
        Class class = NSClassFromString(vcName);
        UIViewController *vc = [[class alloc] init];
        // 2.设置属性
        vc.navigationItem.title = title;
        vc.tabBarItem.title = title;
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:172/255.0 blue:37/255.0 alpha:1.0]} forState:UIControlStateNormal];
        vc.tabBarItem.image = [UIImage imageNamed: image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed: selectedImg];
        // 3.创建导航控制器
        UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:vc];
        //vcNav.navigationBar.translucent = YES;
        //vcNav.navigationBar.barTintColor = [UIColor whiteColor];
        vcNav.navigationBar.tintColor = [UIColor blackColor];
        [vcNav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        // 4.添加到标签栏控制器
        [self addChildViewController:vcNav];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
