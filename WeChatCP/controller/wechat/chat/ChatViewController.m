//
//  ChatViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatViewController.h"
#import "User.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setnavigationItem];
    self.user = [User sharedInstance];
}

- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        User *user = [[User alloc] init];
        user.userID = @"1002";
        user.name = @"liwuyi";
        self.partner = user;
    }
    return self;
}

- (instancetype)initWithGroupId:(NSString *)groupId
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setnavigationItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetChatVC) name:NOTI_CHAT_VIEW_RESET object:nil];
}

- (void)leftClick:(UIBarButtonItem *)left
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
