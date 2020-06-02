//
//  ChatViewController+Delegate.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatViewController+Delegate.h"
#import "OssManager.h"

@implementation ChatViewController (Delegate)

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
            [self localPhoto];
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
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // 固定方向
        //            image = [image fixOrientation];//这个方法是UIImage+Extras.h中方法
            //压缩图片质量
            image = [self reduceImage:image percent:0.1];
            CGSize imageSize = image.size;
            imageSize.height = 320;
            imageSize.width = 320;
            //压缩图片尺寸
            image = [self imageWithImageSimple:image scaledToSize:imageSize];

        }

        // 上传服务器
        NSString *timeStr = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        NSString *imgName = [NSString stringWithFormat:@"%@/chat/%@/%@.jpeg", self.user.chat_userID, self.partner.chat_userID, timeStr];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [[OssManager sharedOssManager] uploadFile:imgName data:data];


        // 关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *fileUrl = info[UIImagePickerControllerMediaURL];
        NSData *file = [NSData dataWithContentsOfURL:fileUrl];
        // 上传服务器
        NSString *timeStr = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        NSString *imgName = [NSString stringWithFormat:@"%@/chat/%@/%@.mp4", self.user.chat_userID, self.partner.chat_userID, timeStr];
        [[OssManager sharedOssManager] uploadFile:imgName data:file];

        // 关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
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
- (void)localPhoto
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


// 压缩图片质量
- (UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
// 压缩图片尺寸
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
