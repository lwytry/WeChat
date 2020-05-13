//
//  MessageDisplayView.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageDisplayView.h"
#import "MessageDisplayView+Delegate.h"
#import <Masonry/Masonry.h>
#import "Macro.h"

#define PAGE_MESSAGE_COUNT 15

@interface MessageDisplayView ()

// 用户决定新消息是否显示时间
@property (nonatomic, strong) NSDate *curDate;

@end

@implementation MessageDisplayView
@synthesize tabView = _tableView;
@synthesize data = _data;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tabView];
        [self registerCellClassForTableView:self.tabView];
        [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTabView)];
        [self.tabView addGestureRecognizer:tap];
//        [self.tabView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    CGFloat viewHeight = self.frame.size.height;
    if (self.tabView.contentSize.height > viewHeight) {
        CGFloat offsetY = self.tabView.contentSize.height - viewHeight;
        CGPoint point = self.tabView.contentOffset;
        point.y = offsetY;
        [self.tabView setContentOffset:point animated:animation];
    }
}

- (void)didTouchTabView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayViewDidTouched:)]) {
        [self.delegate chatMessageDisplayViewDidTouched:self];
    }
}

- (void)dealloc
{
//    [self.tabView removeObserver:self forKeyPath:@"bounds"];
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (UITableView *)tabView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
    }
    return _tableView;
}


#pragma mark - # Public Methods

- (void)addMessage:(Message *)message
{
    
    [self.data addObject:message];
    [self.tabView reloadData];
}

- (void)updateMessage:(Message *)message
{
//    NSArray *visibleCells = [self.tabView visibleCells];
}

- (void)reloadData
{
    [self.tabView reloadData];
}

- (void)resetMessageView
{
    [self.data removeAllObjects];
    [self.tabView reloadData];
    self.curDate = [NSDate date];
    
}


@end
