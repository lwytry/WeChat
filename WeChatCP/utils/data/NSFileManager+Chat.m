//
//  NSFileManager+Chat.m
//  WeChatCP
//
//  Created by lwy on 2020/5/17.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "NSFileManager+Chat.h"
#import "NSFileManager+path.h"
#import "UserHelper.h"

@implementation NSFileManager (Chat)
+ (NSString *)pathDBCommon
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Setting/DB/", [NSFileManager documentsPath], [UserHelper sharedHelper].userId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"common.sqlite3"];
}

+ (NSString *)pathDBMessage
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/DB/", [NSFileManager documentsPath], [UserHelper sharedHelper].userId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"message.sqlite3"];
}

+ (NSString *)pathUserChatImage:(NSString *)imageName dstId:(nonnull NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/%@/image/", [NSFileManager documentsPath], [UserHelper sharedHelper].userId, dstId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatImageForOss:(NSString *)imageName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/image/", [UserHelper sharedHelper].userId, dstId];
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathPartnerImageForOss:(NSString *)imageName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/image/", dstId, [UserHelper sharedHelper].userId];
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatVideoImage:(NSString*)imageName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/%@/videoimage/", [NSFileManager documentsPath], [UserHelper sharedHelper].userId, dstId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatVideo:(NSString*)videoName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/%@/video/", [NSFileManager documentsPath], [UserHelper sharedHelper].userId, dstId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:videoName];
}

+ (NSString *)pathUserChatVideoImageForOss:(NSString*)imageName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/videoimage/", dstId, [UserHelper sharedHelper].userId];
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatVideoForOss:(NSString*)videoName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/video/", dstId, [UserHelper sharedHelper].userId];
    return [path stringByAppendingString:videoName];
}

+ (NSString *)pathPartnerVideoImageForOss:(NSString*)imageName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/videoimage/", dstId, [UserHelper sharedHelper].userId];
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathPartnerVideoForOss:(NSString*)videoName dstId:(NSString *)dstId
{
    NSString *path = [NSString stringWithFormat:@"User/%@/Chat/%@/video/", dstId, [UserHelper sharedHelper].userId];
    return [path stringByAppendingString:videoName];
}

@end
