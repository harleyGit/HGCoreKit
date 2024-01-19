//
//  UIImage+Util.h
//  AccModuleSDK
//
//  Created by GangHuang on 2023/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Util)


/// 图片尺寸和颜色
/// - Parameters:
///   - size: 尺寸·
///   - color: 颜色
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color;

/// 转换图片到指定大小
/// - Parameter reSize: 尺寸
- (UIImage *)transformToSize:(CGSize)reSize;
@end

NS_ASSUME_NONNULL_END
