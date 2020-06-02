//
//  MessageImageView.h
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageImageView : UIImageView

@property (nonatomic, strong) UIImage *backgroundImage;

/**
*  设置消息图片（规则：收到消息时，先下载缩略图到本地，再添加到列表显示，并自动下载大图）
*
*  @param imagePath    缩略图Path
*  @param imageURL     高清图URL
*/
- (void)setTumbnailPath:(NSString *)imagePath hightDefinitionImageURL:(NSString *)imageURL;

@end

NS_ASSUME_NONNULL_END
