//
//  WeChatViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WeChatViewController.h"
#import "WeChat.h"
#import "WeChatTableViewCell.h"
#import "WeChatDetailViewController.h"
#import "SearchResultController.h"
@interface WeChatViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabView;
@property (copy, nonatomic) NSMutableArray<WeChat *> *wechats;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultController *searchResultController;
@end

@implementation WeChatViewController
static NSString *ID = @"wechatCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tabView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tabView.tableFooterView = [[UITableView alloc] init];
    
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

-(NSMutableArray<WeChat *> *)wechats
{
    if (_wechats == nil) {
        _wechats = [[[WeChat alloc] init] getModels];
    }
    return _wechats;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeChatDetailViewController *view = [[WeChatDetailViewController alloc] init];
    view.passedValue = self.wechats[indexPath.row].titleText;
    [self.navigationController pushViewController:view animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WeChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WeChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    }
    [cell configCell:self.wechats[indexPath.row]];
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wechats.count;
}


@end
