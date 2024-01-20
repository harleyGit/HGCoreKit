//
//  LayoutView.h
//  MLC
//
//  Created by Gang Huang on 11/13/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//
//  UICollectionView用法: https://blog.csdn.net/u014773226/article/details/54310866
/// MVC和MVVM使用: https://www.cnblogs.com/mysweetAngleBaby/articles/15974917.html


#import <UIKit/UIKit.h>

#import "LayoutViewVM.h"

#import "LayoutViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LayoutView : UIView<UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout,
                                UIScrollViewDelegate>

@property(nonatomic, strong, readonly, getter = listView) UICollectionView *collectionView;
@property(nonatomic, weak)id<LayoutViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                 layoutConfig:(nullable UICollectionViewFlowLayout *)viewLayout;

- (instancetype)initWithFrame:(CGRect)frame
                 layoutConfig:(nullable UICollectionViewFlowLayout *)viewLayout
                    viewModel:(LayoutViewVM *)viewModel;

- (nullable LayoutViewVM *)setupLayoutViewModel;

/// 适配隐藏导航栏,列表view下移
- (void)setupContentInsetAdjust;
- (void)setupRefreshAndLoadMoreConfig;
- (void)reloaData;
- (void)setupBgColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
