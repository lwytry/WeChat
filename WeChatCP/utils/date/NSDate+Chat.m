//
//  NSDate+Chat.m
//  WeChatCP
//
//  Created by lwy on 2020/5/7.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "NSDate+Chat.h"

@implementation NSDate (Chat)
- (NSString *)chatTimeInfo
{
//    if ([self isToday]) {       // 今天
//        return self.formatHM;
//    }
//    else if ([self isYesterday]) {      // 昨天
//        return [NSString stringWithFormat:@"昨天 %@", self.formatHM];
//    }
//    else if ([self isThisWeek]){        // 本周
//        return [NSString stringWithFormat:@"%@ %@", self.formatWeekday, self.formatHM];
//    }
//    else {
//        return [NSString stringWithFormat:@"%@ %@", self.formatYMD, self.formatHM];
//    }
    return @"2020年5月6日 12:11";
}

@end
