//
//  ContactStore.m
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ContactStore.h"
#import "ContactSQL.h"
#import "User.h"
@implementation ContactStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [DBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"联系人表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CONTACT_TABLE, CONTACT_TABLE_NAME];
    return [self createTable:CONTACT_TABLE_NAME withSQL:sqlString];
}

- (BOOL)add:(User *)user
{
    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_CONTACT, CONTACT_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        user.userId,
                        user.userName,
                        user.wechatId,
                        user.avatarPath,
                        user.phone,
                        nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (NSMutableArray *)getList
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CONTACT, CONTACT_TABLE_NAME];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            User *user = [[User alloc] init];
            user.userId = [retSet stringForColumn:@"userId"];
            user.userName = [retSet stringForColumn:@"username"];
            user.wechatId = [retSet stringForColumn:@"wechatId"];
            user.avatarPath = [retSet stringForColumn:@"avatarPath"];
            user.phone = [retSet stringForColumn:@"phone"];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

- (User *)getInfoByUId:(NSString *)uId
{
    __block User *user = [[User alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CONTACT_INFO, CONTACT_TABLE_NAME, uId];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            user.userId = [retSet stringForColumn:@"userId"];
            user.userName = [retSet stringForColumn:@"username"];
            user.wechatId = [retSet stringForColumn:@"wechatId"];
            user.avatarPath = [retSet stringForColumn:@"avatarPath"];
            user.phone = [retSet stringForColumn:@"phone"];
        }
        [retSet close];
    }];
    return user;
}
@end
