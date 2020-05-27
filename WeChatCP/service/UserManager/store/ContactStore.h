//
//  ContactStore.h
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "DBBaseStore.h"
@class User;
NS_ASSUME_NONNULL_BEGIN

@interface ContactStore : DBBaseStore

- (BOOL)add:(User *)user;

- (NSMutableArray *)getList;

- (User *)getInfoByUId:(NSString *)uId;

@end

NS_ASSUME_NONNULL_END
