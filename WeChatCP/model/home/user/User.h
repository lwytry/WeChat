//
//  User.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
// 用户ID
@property (nonatomic, strong) NSString *userID;
// 用户头像
//@property (nonatomic, copy) NSString* avatar;

// 用户头像
@property (nonatomic, copy) NSString* name;

// 微信号
@property (nonatomic, copy) NSString* wechatId;
// 昵称
@property (nonatomic, strong) NSString *nikeName;

// 头像URL
@property (nonatomic, strong) NSString *avatarURL;

// 头像Path
@property (nonatomic, strong) NSString *avatarPath;

+ (id)getUserInfo;
+ (id)getFromUser;

@end

NS_ASSUME_NONNULL_END