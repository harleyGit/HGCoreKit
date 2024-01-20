//
//  BaseCollectionCellVM.m
//  MLC
//
//  Created by Gang Huang on 11/26/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "BaseCollectionCellVM.h"

#import "BaseCollectionCell.h"

#import "BaseCCellProtocol.h"


@interface BaseCollectionCellVM()
/// Cell标识符
@property(nonatomic, copy)NSString *cellIdentifier;

@end

@implementation BaseCollectionCellVM

- (Class)cellClassName {
    return BaseCollectionCell.class;
}

- (NSString *)cellIdentifier {
    return [NSString stringWithFormat:@"%@", self.cellClassName];
}

- (CGFloat)insetTop {
    if (!_insetTop) {
        _insetTop = 1.0f;
    }
    return _insetTop;
}

- (CGFloat)insetLeft {
    if (!_insetLeft) {
        _insetLeft = 0.001f;
    }
    return _insetLeft;
}

- (CGFloat)insetBottom {
    if (!_insetBottom) {
        _insetBottom = 1.0f;
    }
    return _insetBottom;
}

- (CGFloat)insetRight {
    if (!_insetRight) {
        _insetRight = 0.001f;
    }
    return _insetRight;
}

-(CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 44.0f;
    }
    return _cellHeight;
}

- (CGSize)cellSize {
    CGFloat cellW = (SCREEN_WIDTH - self.insetRight - self.insetLeft);
    
    return  CGSizeMake(cellW, self.cellHeight);
}

- (CGFloat)cellLineSpace {
    return 0.0001;
}

- (CGFloat)cellInteritemSpace {
    return 0.0001;
}

- (void) regiseterCellViewClassInCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:self.cellClassName forCellWithReuseIdentifier:self.cellIdentifier];
}

- (void) selectAtIndexPath:(NSIndexPath *)indexPath
                     model:(nullable id<BaseCCellProtocol>)model{}




@end
