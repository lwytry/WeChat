//
//  ContactViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ContactViewController.h"
#import <NSArray+SortContact.h>
@interface ContactViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, copy) NSArray* firstSectionData;
@property(nonatomic, copy) NSArray *contacts;
@property(nonatomic, copy) NSArray<NSArray *> *contactSortArray;
@property(nonatomic, strong) UITableView *tabView;
@property(nonatomic, strong) UISearchController *searchController;
@end

@implementation ContactViewController
static NSString *ID = @"contactCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:nil action:nil];
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

  self.contacts = @[
    @"吴正祥",
    @"陈维",
    @"赖杰",
    @"范熙丹",
    @"丁亮",
    @"赵雨彤",
    @"落落",
    @"Leo琦仔",
    @"廖宇超",
    @"Darui Li",
    @"刘洋",
    @"阿光",
    @"王杰",
    @"蔡依林",
    @"周杰伦"
  ];

  [self.contacts sortContactTOTitleAndSectionRow_A_EC:^(
                   BOOL isSuccess, NSArray* titleArray, NSArray* rowArray) {
    if (!isSuccess)
      return;

      self.contactSortArray = rowArray;
      self.sectionTitles = titleArray;
  }];
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
  label.text = [NSString
    stringWithFormat:@"%lu位联系人 ", (unsigned long)self.contacts.count];
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = [UIColor lightGrayColor];
  [view addSubview:label];

  return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return self.firstSectionData.count;
    return [self.contactSortArray[section - 1] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        [cell setRestorationIdentifier:@"aaa"]
        //调整分割线长度
        cell.preservesSuperviewLayoutMargins = false;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:self.firstSectionData[indexPath.row][0]];
        cell.textLabel.text = self.firstSectionData[indexPath.row][1];
    } else {
        cell.textLabel.text = self.contactSortArray[indexPath.section-1][indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"friends_public"];
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    if (section == 0)
        return nil;
    return self.sectionTitles[section-1];
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
  headerLabel.text = self.sectionTitles[section - 1];
  headerLabel.frame = CGRectMake(10, 0, headerView.bounds.size.width,
                                 headerView.bounds.size.height);

  [headerView addSubview:headerLabel];
  return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSLog(@"您点击的索引是:%@", title);
    
    
    return index;
}
@end
