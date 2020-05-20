//
//  UserHelper.h
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserHelper : NSObject

@property (nonatomic, strong) User *user;

@property (nonatomic, strong, readonly) NSString *userId;

@property (nonatomic, strong, readonly) NSString *token;

@property (nonatomic, assign, readonly) BOOL isLogin;

+ (UserHelper *)sharedHelper;

@end

NS_ASSUME_NONNULL_END
