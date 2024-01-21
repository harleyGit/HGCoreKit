//
//  BaseCollectionCellVM.h
//  MLC
//
//  Created by Gang Huang on 11/26/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol HGBaseCollectionCellDataSource;

@protocol BaseCCellProtocol;

@interface BaseCollectionCellVM : NSObject

/// cell类名
@property(nonatomic, strong)Class cellClassName;
/// cell距离section header或者footer的上、下、左、右距离
@property(nonatomic, assign)CGFloat insetTop;
@property(nonatomic, assign)CGFloat insetLeft;
@property(nonatomic, assign)CGFloat insetBottom;
@property(nonatomic, assign)CGFloat insetRight;
/// cell高度
@property(nonatomic, assign)CGFloat cellHeight;
/// cell的size
@property(nonatomic, assign)CGSize cellSize;
/// cell上下间距
@property(nonatomic, assign)CGFloat cellLineSpace;
/// cell左右间距
@property(nonatomic, assign)CGFloat cellInteritemSpace;

/// 注册CollectionView CellView
/// @param collectionView collectionView
- (void) regiseterCellViewClassInCollectionView:(UICollectionView *)collectionView;


/// 选择cell
/// @param indexPath 索引路径
- (void) selectAtIndexPath:(NSIndexPath *)indexPath
                     model:(nullable id<BaseCCellProtocol>)model;

@end

NS_ASSUME_NONNULL_END
