//
//  UIView+Ext.h
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Ext)

/// app主题色
@property(nonatomic, class, strong)UIColor *defaultMainColor;
/// 左边距离margin
@property(nonatomic,assign) CGFloat hg_x;
/// 顶部距离margin
@property(nonatomic,assign) CGFloat hg_y;
@property(nonatomic,assign) CGFloat hg_centerY;
@property(nonatomic,assign) CGFloat hg_centerX;
/// 右边距离margin
@property(nonatomic,assign,readonly) float hg_right;
/// 底部距离margin
@property(nonatomic,assign,readonly) CGFloat hg_bottom;
/// 宽度
@property(nonatomic,assign) CGFloat hg_width;
/// 高度
@property(nonatomic,assign) CGFloat hg_height;


+ (UIView *)topFullScreenView;

/// 绘制圆形
- (void)drawCircle;

/// 绘制圆角
/// - Parameter radius: 半径
- (void)setupCornerRadius:(CGFloat)radius;


/// 图片上下移动,模拟点击 用在引导
/// @param move 移动距离
/// @param duration 间隔时间
- (void)startUpDownTranslationAnimation:(CGFloat)move
                               duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
