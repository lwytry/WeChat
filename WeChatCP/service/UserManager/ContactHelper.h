//
//  ContactHelper.h
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactHelper : NSObject

// 原始数据
@property (nonatomic, strong) NSMutableArray *contactData;

// 格式化后的数据
@property (nonatomic, strong) NSMutableArray *sortdata;

// section header
@property (nonatomic, strong) NSMutableArray *sectionHeader;

// 好友数量
@property (nonatomic, assign, readonly) NSInteger contactCount;

+ (ContactHelper *)sharedContactHelper;

- (User *)getContactInfoByUserId:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
