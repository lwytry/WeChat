//
//  MoreKeyboardItem.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, MoreKeyboardItemType) {
    MoreKeyboardItemTypeImage,
    MoreKeyboardItemTypeCamera,
    MoreKeyboardItemTypeVideo,
    MoreKeyboardItemTypeVideoCall,
    MoreKeyboardItemTypeWallet,
    MoreKeyboardItemTypeTransfer,
    MoreKeyboardItemTypePosition,
    MoreKeyboardItemTypeFavorite,
    MoreKeyboardItemTypeBusinessCard,
    MoreKeyboardItemTypeVoice,
    MoreKeyboardItemTypeCards,
};

@interface MoreKeyboardItem : NSObject

@property (nonatomic, assign)MoreKeyboardItemType type;

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *imagePath;

+ (MoreKeyboardItem *)createByType:(MoreKeyboardItemType)type title:(NSString *)title imagePath:(NSString *)imagePath;

@end
