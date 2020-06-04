//
//  VideoMessage.m
//  WeChatCP
//
//  Created by lwy on 2020/6/3.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "VideoMessage.h"

@implementation VideoMessage
@synthesize videoPath = _videoPath;
@synthesize videoURL = _videoURL;
@synthesize duration = _duration;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeVideo];
    }
    return self;
}

- (NSString *)videoPath
{
    if (_videoPath == nil) {
        _videoPath = [self.content objectForKey:@"videoPath"];
    }
    return _videoPath;
}

- (void)setVideoPath:(NSString *)videoPath
{
    _videoPath = videoPath;
    [self.content setObject:_videoPath forKey:@"videoPath"];
}

- (NSString *)videoURL
{
    if (_videoURL == nil) {
        _videoURL = [self.content objectForKey:@"videoURL"];
    }
    return _videoURL;
}

- (void)setVideoURL:(NSString *)videoURL
{
    _videoURL = videoURL;
    [self.content setObject:_videoURL forKey:@"videoURL"];
}

- (NSString *)duration
{
    if (_duration == nil) {
        _duration = [self.content objectForKey:@"duration"];
    }
    return _duration;
}

- (void)setDuration:(NSString *)duration
{
    _duration = duration;
    [self.content setValue:_duration forKey:@"duration"];
}

- (NSString *)conversationContent
{
    return @"[视频]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}


@end
