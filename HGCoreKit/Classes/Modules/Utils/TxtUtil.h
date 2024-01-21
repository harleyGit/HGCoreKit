//
//  TxtUtil.h
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TxtUtil : NSString

+ (BOOL)isEmptyWithTxt:(NSString *)txt;

/// 计算字符串宽度、高度
/// - Parameters:
///   - text: 文本
///   - font: 字体样式
+ (CGSize)calculateTextSizeWithText:(NSString *)text
                               font:(UIFont *)font;

/// 获取字符串高度
/// - Parameters:
///   - value: 字符串
///   - font: 字体样式
///   - height: 高度
+(CGFloat) widthForStr:(NSString *)value
               font:(UIFont *)font
             height:(float)height;

/// 获取字符串Size
/// - Parameters:
///   - value: 字符串
///   - fontSize: 字体大小
///   - width: 宽度
+(CGSize) heightForStr:(NSString *)value
                font:(UIFont *)font
                width:(float)width;

+ (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width content:(NSString *)content;

/// 计算字符串范围
/// - Parameters:
///   - value: 总字符串
///   - subValuee: 子字符串
+ (NSRange)rangeWithValue:(NSString *)value
                   subValue:(NSString *)subValuee;

/// 字符串未知处理
/// - Parameters:
///   - value: 字符串
///   - defltValue: 默认值
+(NSString *)handelValue:(NSString *)value
        defltValue:(NSString *_Nullable)defltValue;

+(NSString *)handelValue:(NSString *)value;

+ (NSString *)transformWithHot:(NSInteger)hot;
+ (NSString *)transformScore:(NSNumber*)score;

//对当前字符串进行 BASE 64 编码
+ (NSString *)base64EncodeWithTxt:(NSString *)txt;
/// 当前字符串呢解码
+ (NSString *)base64DecodeWithTxt:(NSString *)txt;

/// 富文本+图片
/// @param txt 文本
/// @param picName 图片名称
+ (NSMutableAttributedString *)richTxtWithTxt:(NSString *)txt
                                      picName:(NSString *)picName;

/**
*  使用图像和文本生成上下排列的属性文本
*
*  @param image      图像
*  @param imageWH    图像宽高
*  @param title      标题文字
*  @param fontSize   标题字体大小
*  @param titleColor 标题颜色
*  @param spacing    图像和标题间距
*
*  @return 属性文本
*/
+ (NSMutableAttributedString *)hg_imageTextWithImage:(UIImage *)image
                                           imageWH:(CGFloat)imageWH
                                             title:(NSString *)title
                                          fontSize:(CGFloat)fontSize
                                        titleColor:(UIColor *)titleColor
                                             spacing:(CGFloat)spacing;

/// 数组转字符串
/// @param array array description
+ (NSString *)descriptionWithArray:(NSArray<id> *)array;
/// 字典转字符串
+ (NSString *)descriptionWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
