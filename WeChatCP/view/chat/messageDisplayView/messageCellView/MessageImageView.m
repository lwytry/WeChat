//
//  MessageImageView.m
//  WeChatCP
//
//  Created by lwy on 2020/6/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageImageView.h"

@interface MessageImageView ()

@property (nonatomic, weak) CAShapeLayer *maskLayer;

@property (nonatomic, weak) CALayer *contentLayer;

@end

@implementation MessageImageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.contentsCenter = CGRectMake(0.5, 0.6, 0.1, 0.1);
        maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
        CALayer *contentLayer = [[CALayer alloc] init];
        [contentLayer setMask:maskLayer];
        [self.layer addSublayer:contentLayer];
        
        self.maskLayer = maskLayer;
        self.contentLayer = contentLayer;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.maskLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.contentLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setTumbnailPath:(NSString *)imagePath hightDefinitionImageURL:(NSString *)imageURL
{
    if (imagePath == nil) {
        [self.contentLayer setContents:nil];
    } else {
        UIImage *image = [[UIImage imageNamed:imagePath] copy];
        [self.contentLayer setContents:(id)(image.CGImage)];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    UIImage *image = [backgroundImage copy];
    [self.maskLayer setContents:(id)image.CGImage];
}

- (void)dealloc
{
    NSLog(@"dealloc messageimageview");
}

@end
