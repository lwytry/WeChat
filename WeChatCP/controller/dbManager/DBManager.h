//
//  DBManager.h
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

/*
    FMDatabase这个类, 他不是线程安全的,
    如果在多个线程中同时使用一个FMDataBase对象来存取数据的话, 有可能会发生数据错乱
    因此为了保证线程安全, 要使用FMDatabaseQueue这个类来操作数据
 */
#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

/*
    DB队列 (除IM相关)
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

/*
    IM相关DB队列
 */
@property (nonatomic, strong) FMDatabaseQueue *messageQueue;

+ (DBManager *)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
