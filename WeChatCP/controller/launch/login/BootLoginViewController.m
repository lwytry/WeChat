//
//  BootLoginViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "BootLoginViewController.h"
#import "LoginViewController.h"
#import "LoginBaseViewController.h"
#import "RegisterViewController.h"

@interface BootLoginViewController ()
- (IBAction)LoginBt:(id)sender;
- (IBAction)RegisterBt:(id)sender;

@end

@implementation BootLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)RegisterBt:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (IBAction)LoginBt:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    LoginBaseViewController *nav = [[LoginBaseViewController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
