//
//  MoreKeyboard.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "BaseKeyboard.h"
#import "KeyboardDelegate.h"
#import "MoreKeyboardDelegate.h"

@interface MoreKeyboard : BaseKeyboard

@property (nonatomic, assign) id<MoreKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

+ (MoreKeyboard *)keyboard;

@end
