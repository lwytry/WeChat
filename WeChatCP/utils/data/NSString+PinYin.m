//
//  NSString+PinYin.m
//  WeChatCP
//
//  Created by lwy on 2020/5/24.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "NSString+PinYin.h"

@implementation NSString (PinYin)
- (NSString *)pinyin
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
