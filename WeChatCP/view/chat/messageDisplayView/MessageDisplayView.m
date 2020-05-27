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
#import <MJRefresh/MJRefresh.h>

#define PAGE_MESSAGE_COUNT 15

@interface MessageDisplayView ()

// 用户决定新消息是否显示时间
@property (nonatomic, strong) NSDate *curDate;

@property (nonatomic, strong) MJRefreshNormalHeader *refresHeader;

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
        [self setDisablePullToRefresh:NO];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTabView)];
        [self.tabView addGestureRecognizer:tap];
//        [self.tabView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)setDisablePullToRefresh:(BOOL)disablePullToRefresh
{
    if (disablePullToRefresh) {
        [self.tabView setMj_header:nil];
    }
    else {
        [self.tabView setMj_header:self.refresHeader];
    }
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

#pragma mark - # Private Methods
/**
 *  获取聊天历史记录
 */
- (void)p_tryToRefreshMoreRecord:(void (^)(NSInteger count, BOOL hasMore))complete
{
    __weak typeof(self) weakSelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:getRecordsFromDate:count:completed:)]) {
        [self.delegate chatMessageDisplayView:self getRecordsFromDate:self.curDate count:PAGE_MESSAGE_COUNT completed:^(NSDate *date, NSArray *arr, BOOL hasMore) {
            if (arr.count > 0 && [date isEqualToDate:weakSelf.curDate]) {
                weakSelf.curDate = [arr[0] date];
                [weakSelf.data insertObjects:arr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)]];
                complete(arr.count, hasMore);
            } else {
                complete(0, hasMore);
            }
        }];
    }
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
    if (!self.disablePullToRefresh) {
        [self.tabView setMj_header:self.refresHeader];
    }
    __weak typeof(self) weakSelf = self;
    [self p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
        if (!hasMore) {
            weakSelf.tabView.mj_header = nil;
        }
        if (count > 0) {
            [weakSelf.tabView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat viewHeight = weakSelf.tabView.frame.size.height;
                if (weakSelf.tabView.contentSize.height > viewHeight) {
                    CGFloat offsetY = weakSelf.tabView.contentSize.height - viewHeight;
                    CGPoint point = weakSelf.tabView.contentOffset;
                    point.y = offsetY;
                    [weakSelf.tabView setContentOffset:point animated:NO];
                }
            });
        }
    }];
}

- (MJRefreshNormalHeader *)refresHeader
{
    if (_refresHeader == nil) {
        __weak typeof(self) weakSelf = self;
        _refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
                [weakSelf.tabView.mj_header endRefreshing];
                if (!hasMore) {
                    weakSelf.tabView.mj_header = nil;
                }
                if (count > 0) {
                    [weakSelf.tabView reloadData];
                    [weakSelf.tabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }];
        }];
        _refresHeader.lastUpdatedTimeLabel.hidden = YES;
        _refresHeader.stateLabel.hidden = YES;
        
    }
    return _refresHeader;
}


@end
