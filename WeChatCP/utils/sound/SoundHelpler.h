//
//  SoundHelpler.h
//  WeChatCP
//
//  Created by lwy on 2020/6/5.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundHelpler : NSObject

+ (void)playSoundWithName:(NSString *)soundName;

+ (void)disposeSoundWithName:(NSString *)soundName;

@end
