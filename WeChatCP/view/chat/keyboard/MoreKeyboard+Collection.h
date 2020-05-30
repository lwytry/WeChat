//
//  MoreKeyboard+Collection.h
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MoreKeyboard.h"

@interface MoreKeyboard (Collection)<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign, readonly)NSInteger pageItemCount;

- (void)registerCellClass;

@end
