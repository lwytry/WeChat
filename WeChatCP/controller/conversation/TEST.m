////
////  TEST.m
////  WeChatCP
////
////  Created by lwy on 2020/4/29.
////  Copyright © 2020 lwy. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
////LXChatViewController.m
//@interface LXChatViewController ()<UITableViewDelegate, UITableViewDataSource, LXChatBarViewDelegate>
//
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) LXChatBarView *barView;
//@end
//@implementation LXChatViewController
//
//#pragma mark - life cycle
//- (void)viewDidLoad {
//    //
//    UITableView *tableView = [[UITableView alloc] initWithFrame:tbRect style:UITableViewStylePlain];
//       ...
//    [self.view addSubview:tableView];
//
//    CGRect barRect = CGRectMake(inset.left, CGRectGetMaxY(tbRect), CGRectGetWidth(deviceBounds), 50 + 250 + LXGlobalDefined.safeInset.bottom);
//    LXChatBarView *barView = [[LXChatBarView alloc] initWithFrame:barRect];
//    barView.delegate = self;
//    [self.view addSubview:barView];
//    self.barView = barView;
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//#pragma mark - notification
//- (void)keyboardWillShow:(NSNotification *)notification {
//    //LXLog(@"show keyboard %@", notification);
//    CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    LXLog(@"begin frame %@, end frame %@", NSStringFromCGRect(keyboardBeginFrame), NSStringFromCGRect(keyboardEndFrame));
//    CGSize size = keyboardEndFrame.size;
//    CGRect barFrame = self.barView.frame;
//    UIEdgeInsets inset = LXGlobalDefined.safeInset;
//    CGFloat distance = size.height - inset.bottom + self.barView.barHeight - 50;
//    CGFloat barY = LXdeviceHeight - size.height - self.barView.barHeight;
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.barView.frame = CGRectMake(barFrame.origin.x, barY, barFrame.size.width, barFrame.size.height);
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, distance + insetBottom, 0);
//        if (self.list.count > 0) {
//            [self scrollToListBottomWithAnimation:false needReloadList:false];
//        }
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//- (void)keyboardWillHiden:(NSNotification *)notification {
//    //LXLog(@"hiden keyboard %@", notification);
//    LXBarViewShowType type = self.barView.showType;
//    if (type == LXBarViewShowTypeMore || type == LXBarViewShowTypeEmoji) {
//        return;
//    }
//    CGRect beginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    LXLog(@"begin frame %@, end frame %@", NSStringFromCGRect(beginFrame), NSStringFromCGRect(endFrame));
//    CGRect barFrame = self.barView.frame;
//    UIEdgeInsets inset = LXGlobalDefined.safeInset;
//    CGFloat barY = LXdeviceHeight - inset.bottom - self.barView.barHeight;
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.barView.frame = CGRectMake(barFrame.origin.x, barY, barFrame.size.width, barFrame.size.height);
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom + self.barView.barHeight - 50, 0);
//    }];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    //UIKeyboardWillHideNotification
//    if (self.barView.showType == LXBarViewShowTypeText) {
//        [self.view endEditing:true];
//    } else if (self.barView.showType == LXBarViewShowTypeMore) {
//        CGSize size = self.barView.moreView.frame.size;
//        [self hidenKeyboardSize:size];
//    } else if (self.barView.showType == LXBarViewShowTypeEmoji) {
//        CGSize size = self.barView.emojiView.frame.size;
//        [self hidenKeyboardSize:size];
//    } else if (self.barView.showType == LXBarViewShowTypeAudio) {
//        return;
//    }
//    self.barView.showType = LXBarViewShowTypeNone;
//}
//
//- (void)hidenKeyboardSize:(CGSize)size {
//    CGRect barFrame = self.barView.frame;
//    UIEdgeInsets inset = LXGlobalDefined.safeInset;
//    CGFloat barY = LXdeviceHeight - self.barView.barHeight - inset.bottom;
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.barView.frame = CGRectMake(barFrame.origin.x, barY, CGRectGetWidth(barFrame), CGRectGetHeight(barFrame));
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom + self.barView.barHeight - 50, 0);
//    } completion:^(BOOL finished) {
//        self.barView.emojiView.hidden = true;
//        self.barView.moreView.hidden = true;
//    }];
//}
//
//#pragma mark - LXChatBarViewDelegate
//- (void)barView:(LXChatBarView *)barView willShowKeyboard:(LXBarViewShowType)type size:(CGSize)size {
//    CGRect barFrame = self.barView.frame;
//    UIEdgeInsets inset = LXGlobalDefined.safeInset;
//    CGFloat distance = size.height + barView.barHeight - 50;
//    CGFloat barY = LXdeviceHeight - size.height - barView.barHeight - inset.bottom;
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.barView.frame = CGRectMake(barFrame.origin.x, barY, barFrame.size.width, barFrame.size.height);
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, distance + insetBottom, 0);
//        if (self.list.count > 0) {
//            [self scrollToListBottomWithAnimation:false needReloadList:false];
//        }
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//- (void)barView:(LXChatBarView *)barView willHidenKeyboard:(LXBarViewShowType)type size:(CGSize)size {
//    CGRect barFrame = self.barView.frame;
//    UIEdgeInsets inset = LXGlobalDefined.safeInset;
//    CGFloat barY = LXdeviceHeight - barView.barHeight - inset.bottom;
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.barView.frame = CGRectMake(barFrame.origin.x, barY, CGRectGetWidth(barFrame), CGRectGetHeight(barFrame));
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom, 0);
//    } completion:^(BOOL finished) {
//        self.barView.emojiView.hidden = true;
//        self.barView.moreView.hidden = true;
//    }];
//}
//
//- (void)barView:(LXChatBarView *)barView barHeightWillChange:(CGFloat)height {
//    UIEdgeInsets inset = self.tableView.contentInset;
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, inset.bottom - height, 0);
//        if (self.list.count > 0) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.list.count - 1 inSection:0];
//            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:false];
//        }
//    } completion:^(BOOL finished) {
//        
//    }];
//}
