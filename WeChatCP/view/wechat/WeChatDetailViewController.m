//
//  WeChatDetailViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/13.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WeChatDetailViewController.h"

@interface WeChatDetailViewController ()

@end

@implementation WeChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.passedValue;
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_addArrowArrow"] style:UIBarButtonItemStylePlain target:self action:nil];
}

-(void)leftClick:(UIBarButtonItem *)left
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
