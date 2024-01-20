//
//  UIColor+Ext.h
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// C函数16进制
/// - Parameters:
///   - r: 红色值
///   - g: 绿色值
///   - b: 蓝色值
UIColor *COLOR_RGB(NSUInteger r, NSUInteger g, NSUInteger b);
UIColor *COLOR_RGB_V1(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat alpha);


@interface UIColor (Ext)


/// 根据16进制颜色字符串获取颜色
/// - Parameter hexString: 16进制颜色字符串
+ (UIColor *) colorFromHexCode:(NSString *)hexString;

/// 16进制颜色
/// - Parameter rgbValue: 16进制数值
+ (UIColor *)decimal16_rgbValue:(NSUInteger)rgbValue;

@property (nonatomic, class, readonly, nonnull) UIColor *randomColor;

/**
 The color's alpha component value.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat alpha;

+ (nullable UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha;
+ (nullable UIColor *)colorWithHexString:(nonnull NSString *)hexStr alpha:(float)alpha;
+ (nullable UIColor *)colorWithHexString:(nonnull NSString *)hexStr; //支持alphpa FFFFFF-95 (95为不透明度的百分比); 支持ARGB颜色 AAFFFFFF (0xAA为透明度)

/**
 Returns the color's RGB value as a hex string (lowercase).
 Such as @"0066cc-95".
 if self.alpha = 1.0, there will not has "-95" suffix
 
 It will return nil when the color space is not RGB
 
 @return The color's value as a hex string.
 */
- (nullable NSString *)hexString;



@end

NS_ASSUME_NONNULL_END
