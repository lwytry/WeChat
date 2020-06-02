//
//  KeyboardDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/5/1.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol KeyboardDelegate <NSObject>

@optional
- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardWillDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height;

@end

