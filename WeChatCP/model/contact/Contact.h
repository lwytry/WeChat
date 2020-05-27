//
//  Contact.h
//  WeChatCP
//
//  Created by lwy on 2020/4/13.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject

//// 用户ID
//@property (nonatomic, strong) NSString *userId;
//// 用户头像
//@property (nonatomic, copy) NSString* username;
//// 微信号
//@property (nonatomic, copy) NSString* wechatId;
//
//// 昵称
//@property (nonatomic, strong) NSString *remark;
//
//// 头像URL
//@property (nonatomic, strong) NSString *avatarURL;
//
//// 头像Path
//@property (nonatomic, strong) NSString *avatarPath;

@property (nonatomic, copy) NSString *picName;
@property (nonatomic, copy) NSString *userName;
- (NSMutableArray *) getModels;
@end

NS_ASSUME_NONNULL_END
