//
//  TextMessage.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Message.h"

@interface TextMessage : Message

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSAttributedString *attrText;

@end
