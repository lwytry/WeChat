//
//  MobileLoginViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MobileLoginViewController.h"
#import "PasswordView.h"
#import "CaptchaView.h"
#import <Masonry/Masonry.h>

@interface MobileLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordBaseView;
- (IBAction)changeBt:(UIButton *)sender;
- (IBAction)loginBt:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBt;
@property (nonatomic, readwrite, weak) PasswordView *passwordView;
@property (nonatomic, readwrite, weak) CaptchaView *captchaView;
@end

@implementation MobileLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _setupSubViews];
}
#pragma mark - 设置子控件
- (void)_setupSubViews
{
    self.accountTextField.text = [NSString stringWithFormat:@"+86 %@", self.phoneText];
    self.accountTextField.userInteractionEnabled = NO;
    self.accountTextField.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    
    PasswordView *passwordView = [PasswordView passwordView];
    self.passwordView = passwordView;
    [self.passwordView.passwordFeild addTarget:self action:@selector(passwordFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordBaseView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.passwordBaseView);
        make.width.equalTo(self.passwordBaseView);
    }];
    
    CaptchaView *captchaView = [CaptchaView captchaView];
    self.captchaView = captchaView;
    [self.passwordBaseView addSubview:captchaView];

    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordBaseView.mas_left).offset([[UIScreen mainScreen] bounds].size.width);
        make.top.bottom.equalTo(self.passwordBaseView);
        make.width.equalTo(self.passwordBaseView);
    }];
    [self.nextBt setEnabled:NO];
    [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    
}
-(void)passwordFieldTextChange:(UITextField *)textField
{
    if (textField.text.length) {
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:101/255.0 green:210/255.0 blue:109/255.0 alpha:1]];
        [self.nextBt setEnabled:YES];
    } else {
        [self.nextBt setEnabled:NO];
        
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    }
}
- (IBAction)loginBt:(UIButton *)sender {
}

- (IBAction)changeBt:(UIButton *)sender {
}
@end
