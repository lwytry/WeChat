//
//  MobileViewViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MobileView.h"

@interface MobileView ()
@property (weak, nonatomic) IBOutlet UIButton *zoneNameBt;

@end

@implementation MobileView

- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
}
+(instancetype)moblieView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
//    // 限制电话号码位数
//    self.phoneTextField
    UILabel *leftView = [[UILabel alloc] init];
    [leftView setFont:[UIFont systemFontOfSize:17.0f]];
    self.zoneCodeTextField.leftView = leftView;
    self.zoneCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.zoneCodeTextField.text = @"+86";
}
-(void)dealloc
{
    NSLog(@"mobile销毁");
}
@end
