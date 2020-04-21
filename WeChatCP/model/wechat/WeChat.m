//
//  WeChat.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WeChat.h"
@interface WeChat()
@property(strong, nonatomic) NSArray *pics;
@property(strong, nonatomic) NSArray *titles;
@property(strong, nonatomic) NSArray *times;
@property(strong, nonatomic) NSArray *contents;
@property(strong, nonatomic) NSMutableArray *wechats;
@end
@implementation WeChat
-(NSMutableArray *)wechats
{
    if (_wechats == nil) {
        _wechats = [NSMutableArray array];
        for (int i=0; i<self.titles.count; i++) {
            WeChat *wechat = [[WeChat alloc] init];
            wechat.picName = self.pics[i];
            wechat.titleText = self.titles[i];
            wechat.timeText = self.times[i];
            wechat.contentText = self.contents[i];
            [_wechats addObject:wechat];
        }
    }
    return _wechats;
}
-(NSMutableArray *)getModels
{
    return self.wechats;
}
-(NSArray *)pics
{
    if (_pics == nil) {
        _pics = @[@"IMG_1574",@"IMG_1572",@"IMG_1571",@"IMG_1573",@"wechatDF"];
    }
    return _pics;
}
-(NSArray *)titles
{
    if (_titles == nil) {
        _titles = @[@"我和我的逊蛋兄弟", @"李玉松",@"李嘉浩",@"王亚峰", @"苹果发布会"];
    }
    return _titles;
}
-(NSArray *)times
{
    if (_times == nil) {
        _times = @[@"10:12", @"10:15", @"10:20", @"10:50", @"11:00"];
    }
    return _times;
}
- (NSArray *)contents
{
    if (_contents == nil) {
        _contents = @[@"李玉松:👴🏻你在干嘛", @"👨🏻‍🦳爷爷 求求你📖我", @"👨🏻‍🦳早啊 明天停电", @"👨🏻‍🦳早啊 玩不玩", @"苹果于10月30号晚上22点召开新品发布会"];
    }
    return _contents;
}
@end
