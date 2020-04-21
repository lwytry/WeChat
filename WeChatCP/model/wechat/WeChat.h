//
//  WeChat.h
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeChat : NSObject
@property (nonatomic, copy) NSString *picName;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *timeText;
@property (nonatomic, copy) NSString *contentText;
- (NSMutableArray *) getModels;
@end

NS_ASSUME_NONNULL_END
