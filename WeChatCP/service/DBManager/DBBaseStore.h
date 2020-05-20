//
//  DBBaseStore.h
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "DBManager.h"
#define     TimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])
NS_ASSUME_NONNULL_BEGIN

@interface DBBaseStore : NSObject

// 数据库操作队列 DBManager中获取，默认使用commonQueue
@property (nonatomic, weak)FMDatabaseQueue *dbQueue;

/**
 *  表创建
 */
- (BOOL)createTable:(NSString*)tableName withSQL:(NSString*)sqlString;

/*
 *  新增
 *  返回插入id
 */
- (NSNumber *)excuteAdd:(NSString*)sqlString withArrParameter:(NSArray*)arrParameter;

/*
 *  执行带数组参数的sql语句 (增，删，改)
 */
- (BOOL)excuteSQL:(NSString*)sqlString withArrParameter:(NSArray*)arrParameter;

/*
 *  执行带字典参数的sql语句 (增，删，改)
 */
- (BOOL)excuteSQL:(NSString*)sqlString withDicParameter:(NSDictionary*)dicParameter;

/*
 *  执行格式化的sql语句 (增，删，改)
 */
- (BOOL)excuteSQL:(NSString *)sqlString,...;

/**
 *  执行查询指令
 */
- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void(^)(FMResultSet * rsSet))resultBlock;

@end

NS_ASSUME_NONNULL_END
