//
//  BaseCollectionCell.h
//  MLC
//
//  Created by Gang Huang on 11/19/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@class BaseCollectionCell;


@protocol BaseCellDelegate <NSObject>

@optional
- (void) cellActionType:(NSInteger)actionType data:(id _Nullable)data;

@end

@class BaseCollectionCellM;
@protocol BaseCCellProtocol;


@interface BaseCollectionCell : UICollectionViewCell

@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, strong)UIImageView *avatarIcon;
@property(nonatomic, weak)id<BaseCellDelegate> cellDelegate;


/// 子视图布局
- (void)layoutCellContentSubViews;

/// 绑定model数据
/// @param modelData modelData
//- (void)bindCellModdelData:(id <BaseCCellProtocol>)modelData;
- (void)bindCellModdelData:(id)modelData;

/// 选中的cell
/// - Parameters:
///   - indexPath:索引路径
///   - model: 数据model
- (void)selectCellWithIndexPath:(NSIndexPath *)indexPath
                          model:(id)model;


@end

NS_ASSUME_NONNULL_END
