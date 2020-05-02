//
//  ChatViewController.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBaseViewController.h"

@interface ChatViewController : ChatBaseViewController

- (instancetype)initWithUserId:(NSString *)userId;

- (instancetype)initWithGroupId:(NSString *)groupId;

@end
