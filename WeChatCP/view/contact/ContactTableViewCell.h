//
//  ContactTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ContactTableViewCell : UITableViewCell

- (void)setModel:(User *)user;

@end

