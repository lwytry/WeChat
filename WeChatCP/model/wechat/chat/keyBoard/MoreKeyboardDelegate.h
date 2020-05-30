//
//  MoreKeyboardDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MoreKeyboardItem.h"

@protocol MoreKeyboardDelegate <NSObject>
@optional
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(MoreKeyboardItem *)funcItem;

@end
