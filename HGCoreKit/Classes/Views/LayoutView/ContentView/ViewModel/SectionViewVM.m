//
//  SectionViewVM.m
//  MLC
//
//  Created by Gang Huang on 11/27/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "SectionViewVM.h"
#import "BaseReusableViewVM.h"
#import "BaseCollectionCellVM.h"

#import "BaseCCellProtocol.h"

#import "BaseCollectionCell.h"


@implementation SectionViewVM

- (NSString *)headerIdentifier {
    if (!self.headerVM.headerClassName) {
        return @"BaseReusableView";
    }
    
    return NSStringFromClass(self.headerVM.headerClassName);
}

- (NSString *)cellIdentifier {
    if (!self.cellVM.cellClassName) {
        return @"BaseCollectionCell";
    }
    
    return NSStringFromClass(self.cellVM.cellClassName);
}

- (NSMutableArray<id <BaseCCellProtocol>> *)cellModels {
    if (!_cellModels) {
        _cellModels = [NSMutableArray arrayWithCapacity:20];
    }
    
    return _cellModels;
}

- (NSString *)footerIdentifier {
    if (!self.footerVM.footerClassName) {
        return @"BaseReusableView";
    }
    return NSStringFromClass(self.footerVM.footerClassName);
}

- (CGSize)headerSize {
    return self.headerVM.headerSize;
}

- (CGSize)cellSize {
    return  self.cellVM.cellSize;
}
- (CGSize)cellSizeWithRow:(NSInteger)row {
    if (!self.cellModels || self.cellModels.count <= 0) {
        return CGSizeZero;
    }
    id<BaseCCellProtocol> model = self.cellModels[row];
    
    return model.cellSize;
}

-(CGSize)footerSize {
    return self.footerVM.footerSize;

}

- (UIEdgeInsets)insetOfSection {
    return  UIEdgeInsetsMake(self.cellVM.insetTop, self.cellVM.insetLeft, self.cellVM.insetBottom, self.cellVM.insetRight);
}

- (CGFloat)cellLineSpace {
    return self.cellVM.cellLineSpace;
}

- (CGFloat)cellInteritemSpace {
    return  self.cellVM.cellInteritemSpace;
}

- (instancetype)initWithHeaderVM:(BaseReusableViewVM *)headerVM {
    self = [super init];
    if (self) {
        _headerVM = headerVM;
    }
    return self;
}

- (instancetype)initWithHeaderVM:(BaseReusableViewVM *)headerVM
                          cellVM:(BaseCollectionCellVM *)cellVM {
    self = [super init];
    if (self) {
        _headerVM = headerVM;
        _cellVM = cellVM;
    }
    return self;
}

- (instancetype)initWithHeaderVM:(nullable BaseReusableViewVM *)headerVM
                          cellVM:(nullable BaseCollectionCellVM*)cellVM
                        footerVM:(nullable BaseReusableViewVM *)footerVM {
    self = [super init];
    if (self) {
        _headerVM = headerVM;
        _cellVM = cellVM;
        _footerVM = footerVM;
    }
    return self;
}

- (void)bindModelWithHeaderView:(BaseReusableView *)headerView {
    [self.headerVM bindModelWithHeaderOrFooterView:headerView];
}

- (void) bindModelWithCell:(BaseCollectionCell *)cell row:(NSInteger)row {
    if (!self.cellModels || self.cellModels.count <= 0) {
        return;
    }
    id<BaseCCellProtocol> model = self.cellModels[row];
    [cell bindCellModdelData:model];
}

- (void)bindModelWithFooterView:(BaseReusableView *)footerView {
    [self.footerVM bindModelWithHeaderOrFooterView:footerView];
}

- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath model:(id <BaseCCellProtocol> )model{
    [self.cellVM selectAtIndexPath:indexPath model:model];
}


- (void) registerSubViewClassInCollectionView:(UICollectionView *)collectionView {
    if (self.headerVM) {
        [self.headerVM regiseterHeaderViewClassInCollectionView:collectionView];
    }
    
    if (self.cellVM) {
        [self.cellVM regiseterCellViewClassInCollectionView:collectionView];
    }
    
    if (self.footerVM) {
        [self.footerVM regiseterFooterViewClassInCollectionView:collectionView];
    }
    
}


@end
