//
//  RegisterViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/24.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "RegisterViewController.h"
#import "CaptchaView.h"
#import <Masonry/Masonry.h>
#import <AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ApiHelper.h"

@interface RegisterViewController ()<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneFieldView;
@property (weak, nonatomic) IBOutlet CaptchaView *captchaView;
@property (nonatomic, strong) CaptchaView *captcha;
- (IBAction)registerBt:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;
- (IBAction)cancelBt:(UIButton *)sender;
@property (nonatomic, assign) NSInteger timeOut;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_cancel_black"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _setupSubViews];
}
#pragma mark - 设置子控件
- (void)_setupSubViews
{
    CaptchaView *captchaView = [CaptchaView captchaView];
    [captchaView.captchaBt.layer setCornerRadius:5];
    [captchaView.captchaBt.layer setBorderWidth:1.0];
    self.captcha = captchaView;
    [self.captchaView addSubview:captchaView];
    [captchaView.captchaBt setEnabled:NO];
    [captchaView.captchaBt addTarget:self action:@selector(captchaBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneFieldView addTarget:self action:@selector(phoneFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    [captchaView.captchaField addTarget:self action:@selector(captchaFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.width.equalTo(self.captchaView);
    }];
    [self.registerBt setEnabled:NO];
    [self.registerBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    
}

- (void)captchaBtClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送短信到这个号码: %@", self.phoneFieldView.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 发送验证码
        NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/sendCaptcha?phone=%@", self.phoneFieldView.text]];
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
    NSLog(@"send sendCaptcha");
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
-(void)phoneFieldTextChange:(UITextField *)textField
{
    if (textField.text.length != 0) {
        [self.captcha.captchaBt setEnabled:YES];
    } else {
        [self.captcha.captchaBt setEnabled:NO];
    }
}
-(void)captchaFieldTextChange:(UITextField *)textField
{
    if ((textField.text.length != 0) && (self.phoneFieldView.text.length != 0)) {
        [self.registerBt setBackgroundColor:[UIColor colorWithRed:101/255.0 green:210/255.0 blue:109/255.0 alpha:1]];
        [self.registerBt setEnabled:YES];
    } else {
        [self.registerBt setEnabled:NO];
        
        [self.registerBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    }
}

- (IBAction)registerBt:(UIButton *)sender {
    NSString *phone = self.phoneFieldView.text;
    NSString *code = self.captcha.captchaField.text;
    
    NSDictionary *dic = @{@"phone":phone, @"code":code};
    
    NSString *urlStr = [HOST_URL stringByAppendingString:@"/v1/register"];
    [ApiHelper postUrl:urlStr parameters:dic useToken:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (IBAction)cancelBt:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
