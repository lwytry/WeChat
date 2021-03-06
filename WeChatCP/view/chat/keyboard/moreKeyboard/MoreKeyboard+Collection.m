//
//  MoreKeyboard+Collection.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MoreKeyboard+Collection.h"
#import "MoreKeyboardCell.h"
#define     SPACE_TOP        15
#define     WIDTH_CELL       60

@implementation MoreKeyboard (Collection)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.collectionView registerClass:[MoreKeyboardCell class] forCellWithReuseIdentifier:@"MoreKeyboardCell"];
}
#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.chatMoreKeyboardData.count / self.pageItemCount + (self.chatMoreKeyboardData.count % self.pageItemCount == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoreKeyboardCell" forIndexPath:indexPath];
    NSUInteger index = indexPath.section * self.pageItemCount + indexPath.row;
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    if (tIndex >= self.chatMoreKeyboardData.count) {
        [cell setItem:nil];
    }
    else {
        [cell setItem:self.chatMoreKeyboardData[tIndex]];
    }
    __weak typeof(self) weakSelf = self;
    [cell setClickBlock:^(MoreKeyboardItem *sItem) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(moreKeyboard:didSelectedFunctionItem:)]) {
            [weakSelf.delegate moreKeyboard:weakSelf didSelectedFunctionItem:sItem];
        }
    }];
    return cell;
}

//MARK: UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH_CELL, (collectionView.frame.size.height - SPACE_TOP) / 2 * 0.93);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return (collectionView.frame.size.width - WIDTH_CELL * self.pageItemCount / 2) / (self.pageItemCount / 2 + 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (collectionView.frame.size.height - SPACE_TOP) / 2 * 0.07;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat space = (collectionView.frame.size.width - WIDTH_CELL * self.pageItemCount / 2) / (self.pageItemCount / 2 + 1);
    return UIEdgeInsetsMake(SPACE_TOP, space, 0, space);
}
//Mark: UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
}

#pragma mark - Private Methods -
- (NSUInteger)p_transformIndex:(NSUInteger)index
{
    NSUInteger page = index / self.pageItemCount;
    index = index % self.pageItemCount;
    NSUInteger x = index / 2;
    NSUInteger y = index % 2;
    return self.pageItemCount / 2 * y + x + page * self.pageItemCount;
}

#pragma mark - # Getter
- (NSInteger)pageItemCount
{
    return 8;
}

@end
