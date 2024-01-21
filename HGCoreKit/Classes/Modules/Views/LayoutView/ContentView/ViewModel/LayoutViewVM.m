//
//  LayoutViewVM.m
//  MLC
//
//  Created by Gang Huang on 11/27/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "LayoutViewVM.h"
#import "BaseCollectionCellVM.h"

#import "BaseCollectionCell.h"
#import "BaseReusableView.h"

#import "LayoutViewDelegate.h"


@interface LayoutViewVM ()

@end

@implementation LayoutViewVM

- (NSMutableDictionary<NSString *,SectionViewVM *> *)sectionManager {
    if (!_sectionManager) {
        _sectionManager = [NSMutableDictionary dictionaryWithCapacity:6];
    }
    return _sectionManager;
}

- (BaseCollectionCellVM *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return sectionvm.cellVM;
}

- (void)bindModelWithHeaderView:(BaseReusableView *)headerView indexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    [sectionvm bindModelWithHeaderView:headerView];
}

- (void) bindModelWithCell:(BaseCollectionCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    [sectionvm bindModelWithCell:cell row:indexPath.row];
}

- (void)bindModelWithFooterView:(BaseReusableView *)footerView indexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    [sectionvm bindModelWithFooterView:footerView];
}

- (CGSize)headerViewSizeInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return  sectionvm.headerSize;
}

- (CGSize)cellSizeWithIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return [sectionvm cellSizeWithRow: indexPath.row];
}
- (CGSize) sectionCellSizeInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return  sectionvm.cellSize;
}

-(CGSize)footerViewSizeInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return  sectionvm.footerSize;
}

- (CGFloat)cellLineSpaceInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return sectionvm.cellLineSpace;
}

- (CGFloat)cellInteritemSpaceInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return sectionvm.cellInteritemSpace;
}



- (void) addSectionVM:(SectionViewVM *)sectionVM section:(NSInteger)section {
    NSString *key = [self sectionKey:section];

    [self.sectionManager setObject:sectionVM forKey:key];
}

- (nullable NSString *) headerStringFromClassInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    if (!(sectionvm && sectionvm.headerVM)) {
        return nil;
    }
    
    return sectionvm.headerIdentifier;
}

- (nullable NSString *) cellStringnFromClassInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    if (!(sectionvm && sectionvm.cellVM)) {
        return nil;
    }
    
    return  sectionvm.cellIdentifier;
}

- (nullable NSString *)footerStringnFromClassInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    if (!(sectionvm && sectionvm.footerVM)) {
        return nil;
    }
    
    return  sectionvm.footerIdentifier;
}

- (UIEdgeInsets) insetSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    if (!sectionvm) {
        return UIEdgeInsetsMake(1.0f, 0.001, 1.0f, 0.001);
    }
    return sectionvm.insetOfSection;
}


- (NSString *)sectionKey:(NSInteger)section {
    NSString *sectionKey = [NSString stringWithFormat:@"%ld", (long)section];
    
    return sectionKey;
}

/// 返回section Count
- (NSInteger) sectionCount {
    return self.sectionManager.allKeys.count;
}

- (NSInteger) numberOfCellsInSection:(NSInteger)section {
    NSString *key = [self sectionKey:section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    
    return sectionvm.cellModels.count;
}

- (void) didSelectSectionOfCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    id<BaseCCellProtocol> cellModel = sectionvm.cellModels[indexPath.row];
        
    [sectionvm didSelectCellAtIndexPath:indexPath model:cellModel];
}

- (nullable id)cellModelWithIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self sectionKey:indexPath.section];
    SectionViewVM *sectionvm = [self.sectionManager objectForKey:key];
    id<BaseCCellProtocol> cellModel = sectionvm.cellModels[indexPath.row];
    
    return cellModel;
}


- (void)registerSectionSubViewClassInCollectionView:(UICollectionView *)collectionView {
    //遍历方法详解:https://www.jianshu.com/p/5203a12d333f
    [self.sectionManager enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SectionViewVM * _Nonnull sectionVM, BOOL * _Nonnull stop) {
        if (!sectionVM) {
            return;
        }
        
        [sectionVM registerSubViewClassInCollectionView:collectionView];
    }];
}


@end
