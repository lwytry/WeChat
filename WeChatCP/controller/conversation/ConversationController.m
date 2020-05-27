//
//  WeChatViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ConversationController.h"
#import "Conversation.h"
#import "ConversationTableViewCell.h"
#import "ChatViewController.h"
#import "SearchResultController.h"
#import "MessageManager.h"
#import "MessageManager+ConversationRecord.h"

@interface ConversationController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabView;
@property (copy, nonatomic) NSMutableArray<Conversation *> *data;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultController *searchResultController;
@end

@implementation ConversationController
static NSString *ID = @"wechatCell";

- (id)init
{
    if (self = [super init]) {
        [self initTabBarItem];
        [self p_setManagerDelegate];
        [self p_loadData];
    }
    return self;
}


- (void)p_setManagerDelegate
{
    [[MessageManager sharedInstance] setMessageDelegate:self];
}

- (void)p_loadData
{
    [[MessageManager sharedInstance] conversationRecord:^(NSArray *data) {
        [self.data addObjectsFromArray:data];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tabView];
    
    self.tabView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_setManagerDelegate) name:NOTI_MESSAGE_RECEIVED_DELEGATE object:nil];
}

- (void)initTabBarItem
{
    self.navigationItem.title = @"微信";
    self.tabBarItem.title = @"微信";
    self.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:172/255.0 blue:37/255.0 alpha:1.0]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(UISearchController *)searchController
{
    _searchResultController = [[SearchResultController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultController];
//    self.searchController.searchResultsUpdater = self.searchResultController;
    _searchController.delegate = self.searchResultController;
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation=YES;
     
    //搜索时，背景变模糊
    if (@available(iOS 9.1, *)) {
        _searchController.obscuresBackgroundDuringPresentation=YES;
    } else {
        // Fallback on earlier versions
    }
     
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation=YES;
    _searchController.searchBar.placeholder = @"搜索";
    return _searchController;
}

-(UITableView *)tabView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tabView.rowHeight = 70.0;
    }
    return _tabView;
}

- (void)updateConvList:(Conversation *)data
{
    for (int i=0; i<self.data.count; i++) {
        if (self.data[i].dstID == data.dstID) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            ConversationTableViewCell *cell = [_tabView cellForRowAtIndexPath:index];
            [cell updateConversation:data];
        }
    }
}

- (void)addConversation:(Conversation *)data
{
    [self.data addObject:data];
    [self.tabView reloadData];
}

- (BOOL)isExistConversation:(NSString *)userId
{
    for (Conversation *conv in self.data) {
        if (conv.dstID == userId) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray<Conversation *> *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatViewController *chatVC = [[ChatViewController alloc] initWithUserId:self.data[indexPath.row].dstID];
    ConversationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell clearBadge];
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ConversationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell setModel:self.data[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


@end
