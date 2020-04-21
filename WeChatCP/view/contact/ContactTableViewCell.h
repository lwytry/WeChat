//
//  ContactTableViewCell.h
//  WeChatCP
//
//  Created by lwy on 2020/4/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ContactTableViewCellStyle) {
    ContactTableViewCellStyleDefault = 0,
    ContactTableViewCellStyleSubtitle
};

@interface ContactTableViewCell : UITableViewCell

@property (nonatomic, assign) ContactTableViewCellStyle style;
@property (nonatomic, assign) CGFloat avaCornerRadius;

@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, copy) NSString *name;

@end

