//
//  BaseReusableViewVM.h
//  MLC
//
//  Created by Gang Huang on 11/26/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BaseReusableView;
@class BaseReusableViewM;

@interface BaseReusableViewVM : NSObject

@property(nonatomic, strong)Class headerClassName;
@property(nonatomic, strong)Class footerClassName;
/// 数据model
@property(nonatomic, strong)BaseReusableViewM *model;
/// 顶部view的size
@property(nonatomic, assign)CGSize headerSize;
/// 底部view的size
@property(nonatomic, assign)CGSize footerSize;


/// 注册CollectionView headerView
/// @param collectionView collectionView
- (void) regiseterHeaderViewClassInCollectionView:(UICollectionView *)collectionView;

/// 注册CollectionView footerView
/// @param collectionView collectionView
- (void) regiseterFooterViewClassInCollectionView:(UICollectionView *)collectionView;

/// 绑定section header或者footer view数据
/// @param headerOrFooterView headerOrFooterView
- (void)bindModelWithHeaderOrFooterView:(BaseReusableView *)headerOrFooterView;
@end

NS_ASSUME_NONNULL_END
