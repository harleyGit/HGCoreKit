//
//  SectionViewVM.h
//  MLC
//
//  Created by Gang Huang on 11/27/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BaseCollectionCellVM;
@protocol BaseCCellProtocol;
@class BaseCollectionCell;
@class BaseReusableViewVM;
@class BaseReusableView;

///建议将器cell的数据模型数组暴露成属性 还有header的数据模型暴露成属性进行使用
///在其子类中进行添加怪怪的
@interface SectionViewVM : NSObject

/// section header标识符
@property(nonatomic, readonly)NSString *headerIdentifier;
/// section header管理
@property(nonatomic, strong)BaseReusableViewVM *headerVM;
/// section cell内容管理
@property(nonatomic, strong)BaseCollectionCellVM *cellVM;
/// section cell标识符
@property(nonatomic, readonly)NSString *cellIdentifier;
/// cell数据模型
@property(nonatomic, strong)NSMutableArray<id<BaseCCellProtocol>> *cellModels;
/// section footer管理
@property(nonatomic, strong)BaseReusableViewVM *footerVM;
/// section footer标识符
@property(nonatomic, readonly)NSString *footerIdentifier;
/// cell size
@property(nonatomic, assign)CGSize cellSize __attribute__((deprecated("Use cellSizeWithRow: 方法 instead.")));
/// cell 上下间距
@property(nonatomic, assign)CGFloat cellLineSpace;
/// cell 左右间距
@property(nonatomic, assign)CGFloat cellInteritemSpace;
/// section 顶部view的size
@property(nonatomic, assign)CGSize headerSize;
/// section 底部view的size
@property(nonatomic, assign)CGSize footerSize;
/// section内cell内容距离周围边距
@property(nonatomic, assign)UIEdgeInsets insetOfSection;


/// cell的Size
/// @param row 行数
- (CGSize)cellSizeWithRow:(NSInteger)row;
/// 绑定section headerView数据
/// @param headerView headerView
- (void)bindModelWithHeaderView:(BaseReusableView *)headerView;

/// 绑定cell的数据
/// @param cell cell
/// @param row 行数
- (void) bindModelWithCell:(BaseCollectionCell *)cell row:(NSInteger)row;

/// 绑定section footerView数据
/// @param footerView footerView
- (void)bindModelWithFooterView:(BaseReusableView *)footerView;

/// 初始化
/// @param headerVM 节头管理
- (instancetype)initWithHeaderVM:(nullable BaseReusableViewVM *)headerVM;

/// 初始化
/// @param headerVM 节头管理
/// @param cellVM cell管理
- (instancetype)initWithHeaderVM:(nullable BaseReusableViewVM *)headerVM
                          cellVM:(nullable BaseCollectionCellVM*)cellVM;

/// 初始化
/// @param headerVM 节头管理
/// @param cellVM cell管理
/// @param footerVM 节尾管理
- (instancetype)initWithHeaderVM:(nullable BaseReusableViewVM *)headerVM
                          cellVM:(nullable BaseCollectionCellVM*)cellVM
                        footerVM:(nullable BaseReusableViewVM *)footerVM;

/// 选择cell
/// @param indexPath 索引
/// @param model cell模型
- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath model:(nullable  id<BaseCCellProtocol>)model;

/// 注册section子视图
/// @param collectionView collectionView
- (void) registerSubViewClassInCollectionView:(UICollectionView *)collectionView;
@end

NS_ASSUME_NONNULL_END
