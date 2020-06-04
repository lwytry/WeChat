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
#import <AVFoundation/AVFoundation.h>

@implementation ChatBaseViewController (ImagePicker)

// 选取完成 上传到阿里oss 链接建议为7天有效 7天内拉取记录 下载
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
        NSData *videoData = [NSData dataWithContentsOfURL:fileUrl];
        
        
        AVURLAsset *asset = [AVURLAsset assetWithURL:fileUrl];
        NSString *duration = [NSString stringWithFormat:@"%0.0f", ceil(CMTimeGetSeconds(asset.duration))];
        UIImage *image = [self p_getImageWithAsset:fileUrl];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        // 上传服务器
        NSString *fileName = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        NSString *impagePath = [NSFileManager pathUserChatVideoImage:fileName dstId:self.partner.chat_userID];
        NSString *videoPath = [NSFileManager pathUserChatVideo:fileName dstId:self.partner.chat_userID];
        [[NSFileManager defaultManager] createFileAtPath:[impagePath stringByAppendingString:@".jpg"] contents:imageData attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[videoPath stringByAppendingString:@".mp4"] contents:videoData attributes:nil];
//        NSString *imageOssPath = [NSFileManager pathUserChatVideoImageForOss:[fileName stringByAppendingString:@".jpg"] dstId:self.partner.chat_userID];
//        NSString *videoOssPath = [NSFileManager pathUserChatVideoForOss:[fileName stringByAppendingString:@".mp4"] dstId:self.partner.chat_userID];
//        [[OssManager sharedOssManager] uploadFile:imageOssPath data:imageData];
//        [[OssManager sharedOssManager] uploadFile:videoOssPath data:videoData];
        VideoMessage *message = [[VideoMessage alloc] init];
        message.imagePath = [fileName stringByAppendingString:@".jpg"];
        message.imageSize = image.size;
        message.videoPath = [fileName stringByAppendingString:@".mp4"];
        message.duration = duration;
        [self sendMessage:message];
        // 关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

// 开始拍照
- (void)takePhoto:(UIImagePickerController *)picker
{
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    picker.mediaTypes =  [NSArray arrayWithObjects:@"public.movie", @"public.image", nil];
    //设置闪光灯模式
    picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    // 视频的最大录制时长
    picker.videoMaximumDuration = 30.f;
    // 设置视频的质量
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //相机的模式 拍照/摄像
//    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //先检查相机可用是否
    BOOL cameraIsAvailable = [self checkCamera];
    if (YES == cameraIsAvailable) {
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
        [alert show];
    }
}

// 打开本地相册
- (void)localPhotoLibrary:(UIImagePickerController *)picker
{
    //本地相册不需要检查，因为UIImagePickerController会自动检查并提醒
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

// 获取视频信息
- (void)getSomeMessageWithFilePath:(NSString *)filePath
{
    
    
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:fileUrl];
    
    
    NSString *duration = [NSString stringWithFormat:@"%0.0f", ceil(CMTimeGetSeconds(asset.duration))];
    UIImage *image = [self p_getImageWithAsset:fileUrl];
//    imag = _imageView.image;
//    _timeSecond = duration.integerValue;
}

// 获取视频第一帧
- (UIImage *)p_getImageWithAsset:(NSURL *)videoURL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    CMTime actualTime;
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 600) actualTime:&actualTime error:&error];
    if (error) {
        return nil;
    }
    return [UIImage imageWithCGImage:img];
}

@end
