//
//  DBManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "DBManager.h"
#import "UserHelper.h"
#import "NSFileManager+Chat.h"

static DBManager *manager;

@implementation DBManager

+ (DBManager *)sharedInstance
{
    static dispatch_once_t once;
    NSString *userId = [UserHelper sharedHelper].userId;
    dispatch_once(&once, ^{
        manager = [[DBManager alloc] initWithUserId:userId];
    });
    return manager;
}

- (id)initWithUserId:(NSString *)userId
{
    if (self == [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return self;
}

@end
