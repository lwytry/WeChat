//
//  ChatBaseViewController+MoreKeyboard.m
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+MoreKeyboard.h"
#import "ChatBaseViewController+ImagePicker.h"

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
            } else {
                NSLog(@"相机初始化失败");
            }
        } else {
            [self localPhotoLibrary];
        }
        [imagePickerController setDelegate:self];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
