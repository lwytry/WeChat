//
//  MoreKeyboardCell.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreKeyboardItem.h"

@interface MoreKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) MoreKeyboardItem *item;

@property (nonatomic, strong) void(^clickBlock)(MoreKeyboardItem *item);

@end
