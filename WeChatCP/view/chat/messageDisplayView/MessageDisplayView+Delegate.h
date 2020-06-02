//
//  MessageDisplayView+Delegate.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageDisplayView.h"
#import "TextMessageCell.h"
#import "ImageMessageCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDisplayView (Delegate)<UITableViewDelegate, UITableViewDataSource>
- (void)registerCellClassForTableView:(UITableView *)tabView;
@end

NS_ASSUME_NONNULL_END
