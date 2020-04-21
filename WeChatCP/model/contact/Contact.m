//
//  Contact.m
//  WeChatCP
//
//  Created by lwy on 2020/4/13.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Contact.h"
@interface Contact()
@property(strong, nonatomic) NSArray *pics;
@property(strong, nonatomic) NSArray *names;
@property(strong, nonatomic) NSMutableArray *data;
@end
@implementation Contact
-(NSMutableArray *)getModels
{
    
    return self.data;
}
-(NSMutableArray *)data
{
    if (_data == nil) {
         _data = [NSMutableArray array];
        for (int i=0; i<self.titles.count; i++) {
            Contact *contact = [[Contact alloc] init];
            contact.picName = self.pics[i];
            contact.userName = self.names[i];
            [_data addObject: contact];
        }
    }
    return _data;
}
-(NSArray *)pics
{
    if (_pics == nil) {
        _pics = @[@"wechatDF",@"wechatDF",@"wechatDF",@"wechatDF",@"wechatDF"];
    }
    return _pics;
}
-(NSArray *)titles
{
    if (_names == nil) {
        _names = @[@"我和我的逊蛋兄弟", @"李玉松",@"李嘉浩",@"王亚峰", @"马化腾"];
    }
    return _names;
}
@end
