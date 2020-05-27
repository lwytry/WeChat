//
//  WeChatTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Conversation;
@interface ConversationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)setModel:(Conversation *)conv;
- (void)clearBadge;
- (void)updateConversation:(Conversation *)conv;
@end
