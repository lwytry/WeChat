//
//  MessageProtocol.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageProtocol <NSObject>

- (NSString *)messageCopy;

- (NSString *)conversationContent;

@end
