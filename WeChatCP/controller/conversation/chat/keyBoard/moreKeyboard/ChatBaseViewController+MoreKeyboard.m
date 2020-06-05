//
//  ChatBaseViewController+MoreKeyboard.m
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+MoreKeyboard.h"
#import "ChatBaseViewController+ImagePicker.h"
#import "ChatBaseViewController+WebRTC.h"

@implementation ChatBaseViewController (MoreKeyboard)

#pragma mark - # Delegate
//MARK: MoreKeyboardDelegate
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(MoreKeyboardItem *)funcItem
{
    if (funcItem.type == MoreKeyboardItemTypeCamera || funcItem.type == MoreKeyboardItemTypeImage) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if (funcItem.type == MoreKeyboardItemTypeCamera) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
                [self takePhoto:imagePickerController];
            } else {
                NSLog(@"相机初始化失败");
            }
        } else {
            [self localPhotoLibrary:imagePickerController];
        }
    } else if (funcItem.type == MoreKeyboardItemTypeRTC) {
        WebRTCMessage *message =  [[WebRTCMessage alloc] init];
        message.rtcType = VideoRTC; // 具体根据设么 可以具体判断 简写
        message.fromUser = self.partner;
        message.ownerTyper = MessageOwnerTypeSelf;
        [self launchRTCWithMessage:message];

    } else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
