//
//  OssManager.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface OssManager : NSObject

+ (OssManager *)sharedOssManager;

- (NSString *)getChatFileURL:(NSString *)fileName;

- (void)uploadFile:(NSString *)picName
              data:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
