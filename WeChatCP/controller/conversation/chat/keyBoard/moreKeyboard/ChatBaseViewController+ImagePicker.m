//
//  ChatBaseViewController+ImagePicker.m
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+ImagePicker.h"
#import "OssManager.h"
#import "ChatBaseViewController+Proxy.h"

@implementation ChatBaseViewController (ImagePicker)

// 选取完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        NSString *key = nil;
        if (picker.allowsEditing) {
            key = UIImagePickerControllerEditedImage;
        } else {
            key = UIImagePickerControllerOriginalImage;
        }

        UIImage *image = [info objectForKey:key];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        NSString *fileName = [NSString stringWithFormat:@"%lld.jpg", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        NSString *imagePath = [NSFileManager pathUserChatImage:fileName dstId:self.partner.chat_userID];
        NSString *imageOssPath = [NSFileManager pathUserChatImageForOss:fileName dstId:self.partner.chat_userID];
        
        // 上传服务器
        [[OssManager sharedOssManager] uploadFile:imageOssPath data:imageData];
        [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
        ImageMessage *message = [[ImageMessage alloc] init];
        message.imagePath = fileName;
        message.imageSize = image.size;
        
        [self sendMessage:message];
        
        // 关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *fileUrl = info[UIImagePickerControllerMediaURL];
        NSData *file = [NSData dataWithContentsOfURL:fileUrl];
        // 上传服务器
        NSString *timeStr = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        NSString *imageName = [NSString stringWithFormat:@"%@/chat/%@/%@.mp4", self.user.chat_userID, self.partner.chat_userID, timeStr];
        [[OssManager sharedOssManager] uploadFile:imageName data:file];

        // 关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

// 开始拍照
- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }

    }
}

// 打开本地相册
- (void)localPhotoLibrary
{
    //本地相册不需要检查，因为UIImagePickerController会自动检查并提醒
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", @"public.image", nil];
    [self presentViewController:picker animated:YES completion:nil];
}

//检查相机是否可用
- (BOOL)checkCamera
{
   return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
}

@end
