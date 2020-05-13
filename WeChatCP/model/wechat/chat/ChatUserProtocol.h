//
//  ChatUserProtocol.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ChatUserType) {
    ChatUserTypeUser = 0,
    ChatUserTypeGroup,
};

@protocol ChatUserProtocol <NSObject>

@property (nonatomic, strong, readonly) NSString *chat_userID;

@property (nonatomic, strong, readonly) NSString *chat_username;

@property (nonatomic, strong, readonly) NSString *chat_avatarURL;

@property (nonatomic, assign, readonly) NSInteger chat_userType;

@optional;

- (id)groupMemberByID:(NSString *)userID;

- (NSArray *)groupMembers;

@end

NS_ASSUME_NONNULL_END
