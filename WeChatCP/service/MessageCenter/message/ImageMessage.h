//
//  ImageMessage.h
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageMessage : Message

@property (nonatomic, strong) NSString *imagePath;

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, assign) CGSize imageSize;

@end

NS_ASSUME_NONNULL_END
