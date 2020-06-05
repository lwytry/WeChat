//
//  MoreKeyboardHelper.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MoreKeyboardHelper.h"
#import "MoreKeyboardItem.h"

@implementation MoreKeyboardHelper

- (id)init
{
    if (self = [super init]) {
        self.chatMoreKeyboardData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void)p_initTestData
{
    MoreKeyboardItem *imageItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeImage
                                                               title:@"照片"
                                                           imagePath:@"moreKB_image"];
    MoreKeyboardItem *cameraItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeCamera
                                                                title:@"拍摄"
                                                            imagePath:@"moreKB_video"];
    MoreKeyboardItem *videoItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeVideo
                                                               title:@"小视频"
                                                           imagePath:@"moreKB_sight"];
    MoreKeyboardItem *videoCallItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeRTC
                                                                   title:@"视频通话"
                                                               imagePath:@"moreKB_video_call"];
    MoreKeyboardItem *walletItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeWallet
                                                                title:@"红包"
                                                            imagePath:@"moreKB_wallet"];
    MoreKeyboardItem *transferItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeTransfer
                                                                  title:@"转账"
                                                              imagePath:@"moreKB_pay"];
    MoreKeyboardItem *positionItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypePosition
                                                                  title:@"位置"
                                                              imagePath:@"moreKB_location"];
    MoreKeyboardItem *favoriteItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeFavorite
                                                                  title:@"收藏"
                                                              imagePath:@"moreKB_favorite"];
    MoreKeyboardItem *businessCardItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeBusinessCard
                                                                      title:@"个人名片"
                                                                  imagePath:@"moreKB_friendcard" ];
    MoreKeyboardItem *voiceItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeVoice
                                                               title:@"语音输入"
                                                           imagePath:@"moreKB_voice"];
    MoreKeyboardItem *cardsItem = [MoreKeyboardItem createByType:MoreKeyboardItemTypeCards
                                                               title:@"卡券"
                                                           imagePath:@"moreKB_wallet"];
    [self.chatMoreKeyboardData addObjectsFromArray:@[imageItem, cameraItem, videoItem, videoCallItem, walletItem, transferItem, positionItem, favoriteItem, businessCardItem, voiceItem, cardsItem]];
}

@end
