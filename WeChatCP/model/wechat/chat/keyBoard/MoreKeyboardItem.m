//
//  MoreKeyboardItem.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MoreKeyboardItem.h"

@implementation MoreKeyboardItem

+ (MoreKeyboardItem *)createByType:(MoreKeyboardItemType)type title:(NSString *)title imagePath:(NSString *)imagePath
{
    MoreKeyboardItem *item = [[MoreKeyboardItem alloc] init];
    item.type = type;
    item.title = title;
    item.imagePath = imagePath;
    return item;
}

@end
