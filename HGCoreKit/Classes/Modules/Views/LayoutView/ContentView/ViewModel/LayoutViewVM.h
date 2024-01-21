//
//  LayoutViewVM.h
//  MLC
//
//  Created by Gang Huang on 11/27/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BaseViewModel.h"
#import "SectionViewVM.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LayoutViewSectionType) {
    LayoutViewSectionTypeHeader                     = 0,    //头
    LayoutViewSectionTypeCell                       = 1,    //cell
    LayoutViewSectionTypeFooter                     = 2,    //尾
};

//@class SectionViewVM;
@class BaseCollectionCell;
@class BaseReusableView;
@class BaseCollectionCellVM;


@interface LayoutViewVM : BaseViewModel

@property(nonatomic, strong)NSMutableDictionary<NSString*, SectionViewVM* > *sectionManager;


/// 索引对应的cellViewModel
/// @param indexPath 索引
- (BaseCollectionCellVM *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath;

/// section对应header类标识符
/// @param section section
- (nullable NSString *) headerStringFromClassInSection:(NSInteger)section;

/// section对应cell类型标识符
/// @param section sectionn
- (nullable NSString *) cellStringnFromClassInSection:(NSInteger)section;

/// sectionn对应footer标识符
/// @param section section
- (nullable NSString *)footerStringnFromClassInSection:(NSInteger)section;


/// section内cell距离上、下、左、右距离
/// @param section section
- (UIEdgeInsets) insetSection:(NSInteger)section;

/// 建议: 这个方法弃用,之后不用这个方法了
/// 选择section下的cell
/// @param indexPath 索引
- (void) didSelectSectionOfCellAtIndexPath:(NSIndexPath *)indexPath __attribute__((deprecated("该方法即将弃用,请用 cellModelWithIndexPath:")));
/// 获取对应indexPath的cell数据model
/// @param indexPath 索引路径
- (nullable id)cellModelWithIndexPath:(NSIndexPath *)indexPath;

/// 注册section子视图(header、cell、footer)
/// @param collectionView collectionView
- (void)registerSectionSubViewClassInCollectionView:(UICollectionView *)collectionView;

/// section数量
- (NSInteger)sectionCount;

/// 返回section对应cell数量
/// @param section section
- (NSInteger) numberOfCellsInSection:(NSInteger)section;

/// 添加sectionVM
/// @param sectionVM 节区管理
/// @param section 节区序列
- (void) addSectionVM:(SectionViewVM *)sectionVM section:(NSInteger)section;


/// 绑定header数据
/// @param headerView 节头View
/// @param indexPath 节区索引
- (void)bindModelWithHeaderView:(BaseReusableView *)headerView indexPath:(NSIndexPath *)indexPath;

/// 绑定cell数据
/// @param cell cell
/// @param indexPath 索引
- (void) bindModelWithCell:(BaseCollectionCell *)cell indexPath:(NSIndexPath *)indexPath;


/// 绑定footer数据
/// @param footerView 节尾View
/// @param indexPath 索引
- (void)bindModelWithFooterView:(BaseReusableView *)footerView indexPath:(NSIndexPath *)indexPath;

/// section headerView的size
/// @param section 节区索引
- (CGSize) headerViewSizeInSection:(NSInteger)section;

/// section中cell的size
/// @param section 节区
- (CGSize) sectionCellSizeInSection:(NSInteger)section __attribute__((deprecated("Use the cellSizeWithIndexPath: instead.")));;
- (CGSize) cellSizeWithIndexPath:(NSIndexPath *)indexPath;

/// section footerView的size
/// @param section 节区索引
- (CGSize) footerViewSizeInSection:(NSInteger)section;

/// section中cell上下间距
/// @param section 节区索引
- (CGFloat) cellLineSpaceInSection:(NSInteger)section;

/// section中cell左右间距
/// @param section 节区索引
- (CGFloat) cellInteritemSpaceInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
