//
//  ContactHelper.m
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ContactHelper.h"
#import "ApiHelper.h"
#import "UserHelper.h"
#import <MJExtension/MJExtension.h>
#import "NSString+PinYin.h"
#import "ContactStore.h"
#import <UIKit/UIKit.h>


static ContactHelper *contactHelper = nil;
@interface ContactHelper ()

@property (nonatomic, strong) ContactStore *contactStore;

@end

@implementation ContactHelper

+ (ContactHelper *)sharedContactHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        contactHelper = [[ContactHelper alloc] init];
    });
    return contactHelper;
}

- (id)init
{
    if (self = [super init]) {
        // 初始化好友数据
        [self p_loadData];
    }
    return self;
}

#pragma mark - Private Methods -
- (void)p_loadData
{
    
    // 如果是第一次 拉取服务器资源
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL isInitContact = [userDefault objectForKey:@"initContact"];
    if (isInitContact) {
        self.contactData = [self.contactStore getList];
    } else {
        NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/contact/getList?userId=%@", [UserHelper sharedHelper].userId]];
        [ApiHelper getUrl:urlStr parameters:nil useToken:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *result = responseObject[@"data"];
            NSArray *arr = [User mj_objectArrayWithKeyValuesArray:result];
            [self.contactData addObjectsFromArray:arr];
            for (User *user in arr) {
                [self.contactStore add:user];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        [userDefault setBool:YES forKey:@"initContact"];
    }
    
}

- (NSMutableArray *)p_sortData;
{
    NSMutableArray *ans = [[NSMutableArray alloc] init];
    NSArray *serializeArray = [(NSArray *)self.contactData sortedArrayUsingComparator:^NSComparisonResult(User * obj1, User * obj2) {//排序
        int i;
        NSString *strA = obj1.pinyin;
        NSString *strB = obj2.pinyin;
        
        for (i = 0; i < strA.length && i < strB.length; i ++) {
            char a = [strA characterAtIndex:i];
            char b = [strB characterAtIndex:i];
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;//上升
            }
            else if (a < b) {
                return (NSComparisonResult)NSOrderedAscending;//下降
            }
        }
        
        if (strA.length > strB.length) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if (strA.length < strB.length){
            return (NSComparisonResult)NSOrderedAscending;
        }else{
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    char lastC = '1';
    NSMutableArray *data;
    NSMutableArray *oth = [[NSMutableArray alloc] init];
    for (User *user in serializeArray) {
        char c = [user.pinyin characterAtIndex:0];
        if (!isalpha(c)) {
            [oth addObject:user];
        }
        else if (c != lastC){
            lastC = c;
            if (data && data.count > 0) {
                [ans addObject:data];
            }
            
            data = [[NSMutableArray alloc] init];
            [data addObject:user];
        }
        else {
            [data addObject:user];
        }
    }
    if (data && data.count > 0) {
        [ans addObject:data];
    }
    if (oth.count > 0) {
        [ans addObject:oth];
    }
    return ans;
}
- (NSMutableArray *)p_getSectionHeader
{
    NSMutableArray *section = [[NSMutableArray alloc] init];
    [section addObject:UITableViewIndexSearch];
    for (NSArray *item in self.sortdata) {
        User *user = [item objectAtIndex:0];
        char c = [user.pinyin characterAtIndex:0];
        if (!isalpha(c)) {
            c = '#';
        }
        [section addObject:[NSString stringWithFormat:@"%c", toupper(c)]];
    }
    return section;
}

#pragma mark - Getter
- (NSInteger)contactCount
{
    return self.contactData.count;
}

- (NSMutableArray *)sortdata
{
    if (_sortdata == nil) {
        _sortdata = [[NSMutableArray alloc] init];
        _sortdata = [NSMutableArray arrayWithArray:[self p_sortData]];
    }
    return _sortdata;
}

- (NSMutableArray *)sectionHeader
{
    if (_sectionHeader == nil) {
        _sectionHeader = [[NSMutableArray alloc] init];
        _sectionHeader = [NSMutableArray arrayWithArray:[self p_getSectionHeader]];
    }
    return _sectionHeader;
}

- (NSMutableArray *)contactData
{
    if (_contactData == nil) {
        _contactData = [[NSMutableArray alloc] init];
    }
    return _contactData;
}

- (ContactStore *)contactStore
{
    if (_contactStore == nil) {
        _contactStore = [[ContactStore alloc] init];
    }
    return _contactStore;
}
@end
