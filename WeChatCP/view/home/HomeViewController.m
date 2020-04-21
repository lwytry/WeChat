//
//  HomeViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "HomeViewController.h"
#import "Person.h"
#import "HomeTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, copy) NSArray *imgArr;
@end

@implementation HomeViewController
static NSString *ID = @"homeCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_camera"] style:UIBarButtonItemStylePlain target:nil action:nil];
    [self initializeData];
    [self buildTableView];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)initializeData
{
    Person* user = [[Person alloc] init];
    user.avatar = @"IMG_0595";
    user.name = @"Try";
    user.wechatId = @"2020783236";
    _dataArr = @[
      @[ user ],
      @[ @"相册", @"收藏", @"钱包", @"卡包" ],
      @[ @"表情" ],
      @[ @"设置" ]
    ];

    _imgArr = @[
      @[ @"" ],
      @[
        @"mine_album",
        @"mine_favorites",
        @"mine_wallet",
        @"mine_card"
      ],
      @[ @"mine_expression" ],
      @[ @"mine_setting" ]
    ];
}
-(void)buildTableView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tabView.scrollEnabled = false;
    }
    [self.view addSubview: _tabView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
        if (indexPath.section == 0) {
            cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HomeTableViewCell *homeCell = (HomeTableViewCell *)cell;
        homeCell.userInfo = self.dataArr[indexPath.section][indexPath.row];
    } else {
        cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 90.0;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 15;
    return 5;
}
@end
