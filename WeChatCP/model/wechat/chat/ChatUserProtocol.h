//
//  ChatUserProtocol.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChatUserProtocol <NSObject>

@property (nonatomic, strong, readonly) NSString *userID;

@property (nonatomic, strong, readonly) NSString *username;

@property (nonatomic, strong, readonly) NSString *avatarURL;

@property (nonatomic, assign, readonly) NSInteger userType;

@optional;

- (id)groupMemberByID:(NSString *)userID;

- (NSArray *)groupMembers;

@end

NS_ASSUME_NONNULL_END
