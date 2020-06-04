//
//  ChatBaseViewController+MessageDisplayView.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+MessageDisplayView.h"
#import "ChatBaseViewController+ChatBar.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "NSFileManager+Chat.h"
#import <AVKit/AVKit.h>


@implementation ChatBaseViewController (MessageDisplayView)
#pragma mark - # Delegate
//MARK: TLChatMessageDisplayViewDelegate
// chatView 点击事件
- (void)chatMessageDisplayViewDidTouched:(MessageDisplayView *)chatTVC
{
    [self dismissKeyobard];
}

- (void)chatMessageDisplayView:(MessageDisplayView *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
    __weak typeof(self) weakSelf = self;
    [[MessageManager sharedInstance] messageRecordForDstId:[self.partner chat_userID] fromDate:date count:count complete:^(NSArray *arr, BOOL hasMore) {
        if (arr.count > 0) {
            int count = 0;
            NSTimeInterval tm = 0;
            for (Message *message in arr) {
                if (++count > MAX_SHOWTIME_MSG_COUNT || tm == 0 || message.date.timeIntervalSince1970 - tm > MAX_SHOWTIME_MSG_SECOND) {
                    tm = message.date.timeIntervalSince1970;
                    count = 0;
                    message.showTime = NO;
                }
                if (message.ownerTyper == MessageOwnerTypeSelf) {
                    message.fromUser = weakSelf.user;
                } else {
                    if ([weakSelf.partner chat_userType] == ChatUserTypeUser) {
                        message.fromUser = weakSelf.partner;
                    } else if ([weakSelf.partner chat_userType] == ChatUserTypeUser){
                        if ([weakSelf.partner respondsToSelector:@selector(groupMemberByID:)]) {
                            message.fromUser = [weakSelf.partner groupMemberByID:message.dstID];
                        }
                    }
                }
            }
        }
        completed(date, arr, hasMore);
    }];
}

- (void)addToShowMessage:(Message *)message
{
//    message.showTime = self
    [self.messageDisplayView addMessage:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageDisplayView scrollToBottomWithAnimation:YES];
    });
}

- (void)resetChatTVC
{
    [self.messageDisplayView resetMessageView];
    
}

- (void)chatMessageDisplayView:(MessageDisplayView *)chatTVC didClickMessage:(Message *)message
{
    if (message.messageType == MessageTypeImage) {
        // 展示聊天图片
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        NSURL *url;
        if ([(ImageMessage *)message imagePath]) {
            NSString *imagePath = [NSFileManager pathUserChatImage:[(ImageMessage *)message imagePath] dstId:message.dstID];
            url = [NSURL fileURLWithPath:imagePath];
        }
        MWPhoto *photo = [MWPhoto photoWithURL:url];
        [data addObject:photo];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:data];
        [browser setDisplayNavArrows:YES];
        [browser setCurrentPhotoIndex:1];
        UINavigationController *broserNavC = [[UINavigationController alloc] initWithRootViewController:browser];
        [self presentViewController:broserNavC animated:YES completion:nil];
    } else if (message.messageType == MessageTypeVideo) {
        NSURL *url;
        if ([(VideoMessage *)message videoPath]) {
            NSString *videoPath = [NSFileManager pathUserChatVideo:[(VideoMessage *)message videoPath] dstId:message.dstID];
            url = [NSURL fileURLWithPath:videoPath];
        }
        AVPlayerViewController *player = [[AVPlayerViewController alloc] init];
        player.player = [AVPlayer playerWithURL:url];
        player.videoGravity = AVLayerVideoGravityResizeAspect;
        [player player];
        [self presentViewController:player animated:YES completion:nil];
        
    }

}


@end
