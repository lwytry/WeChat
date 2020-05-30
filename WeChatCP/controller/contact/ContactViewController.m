//
//  ContactViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactHelper.h"
#import "ContactTableViewCell.h"
#import "UserDetailViewController.h"

@interface ContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *sectionTitles;

@property (nonatomic, copy) NSArray* firstSectionData;

@property(nonatomic, copy) NSArray *contacts;

@property (nonatomic, copy) NSArray<NSArray *> *contactArr;

@property(nonatomic, copy) NSArray<NSArray *> *contactSortArray;

@property(nonatomic, strong) UITableView *tabView;

@property(nonatomic, strong) UISearchController *searchController;

@property(nonatomic, strong)ContactHelper *contactHelper;

@end

@implementation ContactViewController
static NSString *ID = @"contactCell";

- (id)init
{
    if (self = [super init]) {
        [self initTabBarItem];
        self.contactHelper = [ContactHelper sharedContactHelper];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeData];
    [self buildTableView];
}
- (void)initializeData
{
    self.firstSectionData = @[
        @[ @"friends_new", @"新的朋友" ],
        @[ @"friends_group", @"群聊" ],
        @[ @"friends_tag", @"标签" ],
        @[ @"friends_public", @"公众号" ]
    ];
    self.contactArr = self.contactHelper.sortdata;
    self.sectionTitles = self.contactHelper.sectionHeader;
}

- (void)initTabBarItem
{
    self.tabBarItem.title = @"通讯录";
    self.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contactsHL"];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:172/255.0 blue:37/255.0 alpha:1.0]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)buildTableView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tabView.rowHeight = 50.0;
    }
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _tabView.tableHeaderView = _searchController.searchBar;
    _searchController.searchBar.placeholder = @"搜索";
    _tabView.tableFooterView = [self tableFooterView];
    [self.view addSubview:_tabView];
}

#pragma mark - footer
- (UIView*)tableFooterView
{
    UIView* view = [[UIView alloc]
    initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    UILabel* label = [[UILabel alloc] initWithFrame:view.bounds];
    NSInteger num = [ContactHelper sharedContactHelper].contactCount;
    label.text = [NSString
                  stringWithFormat:@"%ld位联系人 ", (long)num];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];

    return view;
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    UserDetailViewController *detailVc = [[UserDetailViewController alloc] initWithUserModdel:self.contactArr[indexPath.section-1][indexPath.row]];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return self.firstSectionData.count;
    return self.contactArr[section - 1].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            //调整分割线长度
            cell.preservesSuperviewLayoutMargins = false;
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
            cell.imageView.image = [UIImage imageNamed:self.firstSectionData[indexPath.row][0]];
            cell.textLabel.text = self.firstSectionData[indexPath.row][1];
        }
        return cell;
    } else {
        ContactTableViewCell *cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setModel:self.contactArr[indexPath.section-1][indexPath.row]];
        return cell;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    return self.sectionTitles;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    return nil;

    UIView* headerView = [[UIView alloc]
    initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];

    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.text = self.sectionTitles[section];
    headerLabel.frame = CGRectMake(10, 0, headerView.bounds.size.width,
                                 headerView.bounds.size.height);

    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 30;
}


-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSLog(@"您点击的索引是:%@", title);
    
    
    return index;
}
@end
