//
//  CaptchaView.h
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaptchaView : UIView
@property (weak, nonatomic) IBOutlet UITextField *captchaField;
+ (instancetype)captchaView;
@property (weak, nonatomic) IBOutlet UIButton *captchaBt;
@end

NS_ASSUME_NONNULL_END
