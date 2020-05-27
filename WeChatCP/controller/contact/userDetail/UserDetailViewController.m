//
//  UserDetailViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/5/25.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "UserDetailViewController.h"
#import "User.h"
#import "UserDetailInfoCell.h"
#import "UserDetailChatBTCell.h"
#import "ChatViewController.h"
#import "LaunchManager.h"
#import <Masonry/Masonry.h>

@interface UserDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

// 用户id
@property (nonatomic, strong, readonly) NSString *userId;
// 用户数据模型
@property (nonatomic, strong) User *userModel;
// 瀑布流列表
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation UserDetailViewController

- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (instancetype)initWithUserModdel:(User *)userModel
{
    if (self = [super init]) {
        _userId = userModel.userId;
        _userModel = userModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"详细信息"];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor colorWithWhite:.95 alpha:1]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_loadData];
}

- (void)p_loadData
{
    [self.collectionView registerClass:[UserDetailInfoCell class] forCellWithReuseIdentifier:@"info"];
    [self.collectionView registerClass:[UserDetailChatBTCell class] forCellWithReuseIdentifier:@"chat"];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserDetailInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"info" forIndexPath:indexPath];
        [cell setModel:self.userModel];
        return cell;
    } else {
        UserDetailChatBTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chat" forIndexPath:indexPath];

        [cell.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)buttonClick
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithUserId:self.userModel.userId];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController *naVC = [LaunchManager sharedInstance].tabBarController.childViewControllers[0];
    [[LaunchManager sharedInstance].tabBarController setSelectedIndex:0];
    [chatVC setHidesBottomBarWhenPushed:YES];
    [naVC pushViewController:chatVC animated:YES];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGSize size = CGSizeMake(self.view.bounds.size.width,80);
        return size;
    } else {
        CGSize size = CGSizeMake(self.view.bounds.size.width,62);
        return size;
    }
}

@end
