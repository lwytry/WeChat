//
//  Person.h
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
/**
 *  用户头像
 */
@property (nonatomic, copy) NSString* avatar;

/**
 *  用户名称
 */
@property (nonatomic, copy) NSString* name;

/**
 *  微信号
 */
@property (nonatomic, copy) NSString* wechatId;
@end

NS_ASSUME_NONNULL_END
