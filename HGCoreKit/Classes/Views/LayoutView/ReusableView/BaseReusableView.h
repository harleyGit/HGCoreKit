//
//  BaseReusableView.h
//  MLC
//
//  Created by Gang Huang on 11/20/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHeaderDelegate.h"

@class BaseReusableViewM;


NS_ASSUME_NONNULL_BEGIN

@interface BaseReusableView : UICollectionReusableView

@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, weak)id<BaseHeaderDelegate> hfDelegate;

/// 绑定Header数据
/// @param modelData 模型数据
- (void)bindHeadOrFooterModelData:(BaseReusableViewM *)modelData;

/// 子视图布局
- (void) layoutHeaderOrFooterSubViews;

@end

NS_ASSUME_NONNULL_END
