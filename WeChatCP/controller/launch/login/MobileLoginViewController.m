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
#import <AFNetworking/AFNetworking.h>
#import "RootTabBarController.h"
#import "ApiHelper.h"

@interface MobileLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordBaseView;
- (IBAction)changeBt:(UIButton *)sender;
- (IBAction)loginBt:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBt;
@property (nonatomic, readwrite, weak) PasswordView *passwordView;
@property (nonatomic, readwrite, weak) CaptchaView *captchaView;
@property (nonatomic, assign) BOOL isPassword;
@property (nonatomic, assign) NSInteger timeOut;
@end

@implementation MobileLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_black"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _setupSubViews];
}

-(void)leftClick:(UIBarButtonItem *)left
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [captchaView.captchaBt.layer setCornerRadius:5];
    [captchaView.captchaBt.layer setBorderWidth:1.0];
    self.captchaView = captchaView;
    [self.passwordBaseView addSubview:captchaView];
    [self.captchaView.captchaBt addTarget:self action:@selector(captchaBtClick) forControlEvents:UIControlEventTouchUpInside];
    [captchaView.captchaField addTarget:self action:@selector(captchaFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordBaseView.mas_left).offset([[UIScreen mainScreen] bounds].size.width);
        make.top.bottom.equalTo(self.passwordBaseView);
        make.width.equalTo(self.passwordBaseView);
    }];
    [self.nextBt setEnabled:NO];
    [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    
}

-(void)captchaFieldTextChange:(UITextField *)textField
{
    if (textField.text.length != 0) {
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:101/255.0 green:210/255.0 blue:109/255.0 alpha:1]];
        [self.nextBt setEnabled:YES];
    } else {
        [self.nextBt setEnabled:NO];
        
        [self.nextBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    }
}

- (void)captchaBtClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送短信到这个号码: %@", self.phoneText] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 发送验证码
        NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/sendCaptcha?phone=%@", self.phoneText]];
        [ApiHelper postUrl:urlStr parameters:nil useToken:NO success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        // 成功则启动定时器
        [self sentPhoneCodeTimeMethod];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:ok];
    
    [alertVC addAction:cancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)sentPhoneCodeTimeMethod {
    //倒计时时间 - 60S
    __block NSInteger timeOut = 5;
    self.timeOut = timeOut;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [self.captchaView.captchaBt setTitle:@"重发验证码" forState:UIControlStateNormal];
                [self.captchaView.captchaBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [self.captchaView.captchaBt setEnabled:YES];
                [self.captchaView.captchaBt setUserInteractionEnabled:YES];
            });
        } else {
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld", seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                NSString *title = [NSString stringWithFormat:@"%@s后重新发送",strTime];
                [self.captchaView.captchaBt setTitle:title forState:UIControlStateNormal];
//              [yourButton.titleLabel setTextAlignment:NSTextAlignmentRight];
                // 设置按钮title居中 上面注释的方法无效
                [self.captchaView.captchaBt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
                [self.captchaView.captchaBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //计时器间不允许点击
                [self.captchaView.captchaBt setUserInteractionEnabled:NO];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
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
    [self.captchaView.captchaField resignFirstResponder];
    NSString *phone = self.phoneText;
    NSString *code = self.captchaView.captchaField.text;
    
    NSDictionary *dic = @{@"phone":phone, @"code":code};
    NSString *urlStr = [HOST_URL stringByAppendingString:@"/v1/login"];
    [ApiHelper postUrl:urlStr parameters:dic useToken:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"errCode"]  isEqual: @0]) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dataDic[@"token"] forKey:@"token"];
            
            NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
            NSString *userId = [NSString stringWithFormat:@"%@", dataDic[@"userInfo"][@"id"]];
            [userInfoDic setValue:userId forKey:@"id"];
            [userInfoDic setValue:dataDic[@"userInfo"][@"username"] forKey:@"username"];
            [userInfoDic setValue:dataDic[@"userInfo"][@"identifier"] forKey:@"identifier"];
            [userInfoDic setValue:dataDic[@"userInfo"][@"phone"] forKey:@"phone"];
            [userInfoDic setValue:dataDic[@"userInfo"][@"avatarPath"] forKey:@"avatarPath"];
            
            [userDefault setObject:userInfoDic forKey:@"userInfo"];
            [userDefault synchronize];
            RootTabBarController *tabBar = [[RootTabBarController alloc] init];
            CATransition *transtition = [CATransition animation];
            transtition.duration = 0.5;
            transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
        } else {
            NSLog(@"请求失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (IBAction)changeBt:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    
    sender.selected = !sender.isSelected;
    CGFloat offsetX1 = sender.isSelected ? [[UIScreen mainScreen] bounds].size.width : 0;
    CGFloat offsetX2 = sender.isSelected ? 0 : [[UIScreen mainScreen] bounds].size.width;
    if (sender.isSelected) {
        [sender setTitle: @"用短信验证码登录" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:91/255.0 green:106/255.0 blue:145/255.0 alpha:1] forState:UIControlStateSelected];
    } else {
        [sender setTitle: @"用微信密码登录" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:91/255.0 green:106/255.0 blue:145/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [self.passwordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordBaseView.mas_left).mas_offset(-1 * offsetX1);
    }];
    [self.captchaView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordBaseView.mas_left).mas_offset(-1 * offsetX2);
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self.passwordBaseView layoutIfNeeded];
    } completion:^(BOOL finished) {
        /// 重新设置
        [sender.isSelected ? self.passwordView : self.captchaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.passwordBaseView.mas_left).with.offset(sender.isSelected?offsetX1:offsetX2);
        }];
        
        sender.userInteractionEnabled = YES;
    }];
}
@end
