//
//  MessageDisplayViewDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageDisplayView;
@protocol MessageDisplayViewDelegate <NSObject>

// 聊天界面被点击, 用于收键盘
- (void)chatMessageDisplayViewDidTouched:(MessageDisplayView *)chatTouchView;

/**
 *  下拉刷新，获取某个时间段的聊天记录（异步）
 *
 *  @param chatTVC   chatTVC
 *  @param date      开始时间
 *  @param count     条数
 *  @param completed 结果Blcok
 */
- (void)chatMessageDisplayView:(MessageDisplayView *)chatTVC
            getRecordsFromDate:(NSDate *)date
                         count:(NSUInteger)count
                     completed:(void (^)(NSDate *, NSArray *, BOOL))completed;
@end

