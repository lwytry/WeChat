//
//  NSFileManager+path.h
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (path)
+ (NSURL *)documentsURL;
+ (NSString *)documentsPath;
@end

NS_ASSUME_NONNULL_END
