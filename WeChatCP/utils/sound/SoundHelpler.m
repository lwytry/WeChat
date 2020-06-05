//
//  SoundHelpler.m
//  WeChatCP
//
//  Created by lwy on 2020/6/5.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "SoundHelpler.h"
#import <AudioToolbox/AudioToolbox.h>

static NSMutableDictionary *soundDict;

@implementation SoundHelpler

+ (void)initialize{
    
    soundDict = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithName:(NSString *)soundName
{
    SystemSoundID soundId = 0;
    CFURLRef urlRef = (__bridge CFURLRef)([[NSBundle mainBundle]URLForResource:soundName withExtension:nil]);
    AudioServicesCreateSystemSoundID(urlRef, &soundId);
    [soundDict setObject:@(soundId) forKey:soundName];
    
    AudioServicesPlayAlertSound(soundId);
}

+ (void)disposeSoundWithName:(NSString *)soundName
{
    SystemSoundID soundId = [soundDict[soundName]unsignedIntValue];
    if (soundId != 0) {
        AudioServicesDisposeSystemSoundID(soundId);
        [soundDict removeObjectForKey:@(soundId)];
    }
    
}

@end
