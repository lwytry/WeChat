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

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneFieldView;
@property (weak, nonatomic) IBOutlet CaptchaView *captchaView;
@property (nonatomic, strong) CaptchaView *captcha;
- (IBAction)registerBt:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;
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
    [captchaView.captchaBt addTarget:self action:@selector(captchaBtClick) forControlEvents:UIControlEventTouchUpInside];
    [captchaView.captchaField addTarget:self action:@selector(captchaFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.width.equalTo(self.captchaView);
    }];
    [self.registerBt setEnabled:NO];
    [self.registerBt setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    
}

- (void)captchaBtClick
{
    NSLog(@"发送雁阵吗");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送短信到这个号码: %@", self.phoneFieldView.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 发送验证码
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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    NSString *url = @"http://localhost:8080/v1/register";
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
//    NSMutableURLRequest* formRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://localhost:8080/v1/register" parameters:dic error:nil];
//
//    [formRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//
//    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
//
//    AFJSONResponseSerializer* responseSerializer = [AFJSONResponseSerializer serializer];
//
//    [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil]];
//
//    manager.responseSerializer= responseSerializer;
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:formRequest uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        NSLog(@"%@ %@", response, responseObject);
//    }];
//
//    [dataTask resume];
}
@end
