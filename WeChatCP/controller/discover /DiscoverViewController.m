//
//  DiscoverViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, copy) NSArray *imgArr;
@end

@implementation DiscoverViewController
static NSString *ID = @"discoverCell";

- (id)init
{
    if (self = [super init]) {
        [self initTabBarItem];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeData];
    [self buildTableView];
}

-(void) initializeData
{
    _dataArr = @[
      @[ @"朋友圈" ],
      @[ @"扫一扫", @"摇一摇" ],
      @[ @"附近的人" ],
      @[ @"购物", @"游戏" ]
    ];

    _imgArr = @[
      @[ @"discover_album" ],
      @[ @"discover_scaner", @"discover_shake" ],
      @[ @"discover_location" ],
      @[ @"discover_shopping", @"discover_game" ]
    ];
}

- (void)initTabBarItem
{
    self.tabBarItem.title = @"发现";
    self.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discoverHL"];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:172/255.0 blue:37/255.0 alpha:1.0]} forState:UIControlStateNormal];
}

-(void) buildTableView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tabView.rowHeight = 44.0;

        _tabView.tableFooterView = [[UITableView alloc] init];
    }
    [self.view addSubview:_tabView];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了-%ld组, 第%ld个", (long)indexPath.section, indexPath.row);
}

@end
