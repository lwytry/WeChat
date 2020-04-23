//
//  LoginBaseViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/23.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "LoginBaseViewController.h"

@interface LoginBaseViewController ()

@end

@implementation LoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [super viewWillAppear:animated];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
@end
