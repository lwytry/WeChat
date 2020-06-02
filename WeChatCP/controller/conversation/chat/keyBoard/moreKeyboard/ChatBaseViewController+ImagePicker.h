//
//  ChatBaseViewController+ImagePicker.h
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"

@interface ChatBaseViewController (ImagePicker) <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)localPhotoLibrary;

@end
