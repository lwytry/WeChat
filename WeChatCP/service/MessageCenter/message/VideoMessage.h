//
//  VideoMessage.h
//  WeChatCP
//
//  Created by lwy on 2020/6/3.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoMessage : ImageMessage

@property (nonatomic, strong) NSString *videoPath;

@property (nonatomic, strong) NSString *videoURL;

@property (nonatomic, assign) NSString *duration;

@end

NS_ASSUME_NONNULL_END
