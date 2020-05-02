//
//  MobileViewViewController.h
//  WeChatCP
//
//  Created by lwy on 2020/4/22.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobileView : UIView
@property (weak, nonatomic) IBOutlet UITextField *zoneCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)moblieView;
@end

NS_ASSUME_NONNULL_END
