//
//  Contact.h
//  WeChatCP
//
//  Created by lwy on 2020/4/13.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject
@property (nonatomic, copy) NSString *picName;
@property (nonatomic, copy) NSString *userName;
- (NSMutableArray *) getModels;
@end

NS_ASSUME_NONNULL_END
