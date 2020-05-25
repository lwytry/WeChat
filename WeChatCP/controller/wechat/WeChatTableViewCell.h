//
//  WeChatTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeChat.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void) setModel:(WeChat *)wechat;
@end

NS_ASSUME_NONNULL_END
