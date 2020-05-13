//
//  NSString+Message.h
//  WeChatCP
//
//  Created by lwy on 2020/5/13.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Message)
- (NSAttributedString *)toMessageString;
@end

NS_ASSUME_NONNULL_END
