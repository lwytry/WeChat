//
//  ChatBaseViewController.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"
#import <Masonry/Masonry.h>
#import "ChatBaseViewController+ChatBar.h"
#import "ChatBaseViewController+MessageDisplayView.h"


@interface ChatBaseViewController ()

@end

@implementation ChatBaseViewController
-(void)loadView
{
    [super loadView];
    
    [[MessageManager sharedInstance] setMessageDelegate:self];
    
    [self.view addSubview:self.messageDisplayView];
    [self.view addSubview:self.chatBar];
    if (SAFEAREA_INSETS_BOTTOM > 0) {
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.chatBar.mas_bottom);
        }];
    }
    [self p_addMasonry];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadKeyboard];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma mark - # Public Methods

- (void)setPartner:(id<ChatUserProtocol>)partner
{
    _partner = partner;
    [self.navigationItem setTitle:[_partner chat_username]];
    [self resetChatVC];
}

- (void)resetChatVC
{
    [self.view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    [self resetChatTVC];
}

#pragma mark - # Private methods
- (void)p_addMasonry
{
    [self.messageDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.chatBar.mas_top);
    }];
    [self.chatBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-SAFEAREA_INSETS_BOTTOM);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    [self.view layoutIfNeeded];
}

- (MessageDisplayView *)messageDisplayView
{
    if (_messageDisplayView == nil) {
        _messageDisplayView = [[MessageDisplayView alloc] init];
        [_messageDisplayView setDelegate:self];
    }
    return _messageDisplayView;
}

- (ChatBar *)chatBar
{
    if (_chatBar == nil) {
        _chatBar = [[ChatBar alloc] init];
        [_chatBar setDelegate:self];
    }
    return _chatBar;
}
@end
