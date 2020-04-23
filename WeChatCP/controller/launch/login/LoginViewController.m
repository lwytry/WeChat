//
//  LoginViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "LoginViewController.h"
#import "MobileView.h"
#import "AccountView.h"
#import "MobileLoginViewController.h"
#import <Masonry/Masonry.h>
@interface LoginViewController ()
- (IBAction)loginBt:(UIButton *)sender;
- (IBAction)changeLoginBt:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBt;
@property (weak, nonatomic) IBOutlet UIView *accessBaseView;

@property (nonatomic, readwrite, weak) MobileView *mobileLoginView;
@property (nonatomic, readwrite, weak) AccountView *accountLoginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more_black"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_cancel_black"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [self _setupSubView];
    
}
- (void)more
{
    UIAlertController *alertVC = [[UIAlertController alloc] init];
    UIAlertAction *frozen = [UIAlertAction actionWithTitle:@"紧急冻结" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *securityCenter = [UIAlertAction actionWithTitle:@"安全中心" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:frozen];
    [alertVC addAction:securityCenter];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_setupSubView
{
    MobileView *mobileView = [MobileView moblieView];
    self.mobileLoginView = mobileView;
    [self.mobileLoginView.phoneTextField addTarget:self action:@selector(mobilePhoneTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.accessBaseView addSubview:mobileView];
    [mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.accessBaseView);
        make.width.equalTo(self.accessBaseView);
    }];
    
    AccountView *accountView = [AccountView accountView];
    self.accountLoginView = accountView;
    [self.accessBaseView addSubview:accountView];

    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accessBaseView.mas_left).offset([[UIScreen mainScreen] bounds].size.width);
        make.top.bottom.equalTo(self.accessBaseView);
        make.width.equalTo(self.accessBaseView);
    }];
    [self.nextBt setEnabled:NO];
    
    [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
}

-(void)mobilePhoneTextChange:(UITextField *)textField
{
    if (textField.text.length) {
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:101/255.0 green:210/255.0 blue:109/255.0 alpha:1]];
        [self.nextBt setEnabled:YES];
    } else {
        [self.nextBt setEnabled:NO];
        
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    }
}

- (IBAction)changeLoginBt:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    
    sender.selected = !sender.isSelected;
    CGFloat offsetX1 = sender.isSelected ? [[UIScreen mainScreen] bounds].size.width : 0;
    CGFloat offsetX2 = sender.isSelected ? 0 : [[UIScreen mainScreen] bounds].size.width;
    if (sender.isSelected) {
        [sender setTitle: @"用手机号登录" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:91/255.0 green:106/255.0 blue:145/255.0 alpha:1] forState:UIControlStateSelected];
        [self.nextBt setTitle:@"登录" forState:UIControlStateNormal];
    } else {
        [sender setTitle: @"用微信号/QQ号/邮箱登录" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:91/255.0 green:106/255.0 blue:145/255.0 alpha:1] forState:UIControlStateNormal];
        [self.nextBt setTitle:@"下一步" forState:UIControlStateNormal];
    }
    [self.mobileLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accessBaseView.mas_left).mas_offset(-1 * offsetX1);
    }];
    [self.accountLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accessBaseView.mas_left).mas_offset(-1 * offsetX2);
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self.accessBaseView layoutIfNeeded];
    } completion:^(BOOL finished) {
        /// 重新设置
        [sender.isSelected ? self.mobileLoginView : self.accountLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accessBaseView.mas_left).with.offset(sender.isSelected?offsetX1:offsetX2);
        }];
        
        sender.userInteractionEnabled = YES;
    }];
}

- (IBAction)loginBt:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"下一步"]) {
        MobileLoginViewController *mobileLoginVC = [[MobileLoginViewController alloc] init];
        mobileLoginVC.phoneText = self.mobileLoginView.phoneTextField.text;
        [self.navigationController pushViewController:mobileLoginVC animated:YES];
    }
}
@end
