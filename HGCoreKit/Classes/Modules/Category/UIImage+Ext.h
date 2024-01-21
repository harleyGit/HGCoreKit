//
//  UIImage+Ext.h
//  AccModuleSDK
//
//  Created by GangHuang on 2023/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Ext)


/// 图片尺寸和颜色
/// - Parameters:
///   - size: 尺寸·
///   - color: 颜色
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color;

/// 转换图片到指定大小
/// - Parameter reSize: 尺寸
- (UIImage *)transformToSize:(CGSize)reSize;

- (UIImage *)setupImgSize:(CGSize)size;

-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color;


/// 转换图片到指定大小
/// - Parameter reSize: 尺寸
- (UIImage *)transformToSize:(CGSize)reSize;
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size;
+ (UIImage *)combinateCodeImage:(UIImage *)codeImage andLogo:(UIImage *)logo;
+ (UIImage *)generateCode128:(NSString *)code size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 通过颜色创建 UIImage

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColorString:(NSString *)string;
+ (UIImage *)imageWithColorString:(NSString *)string cornerRadius:(CGFloat)radius withSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius withSize:(CGSize)size;
+ (UIImage *)imageWithColorString:(NSString *)string dash:(CGFloat *)dash withSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color dash:(CGFloat *)dash withSize:(CGSize)size;

/// 可设置border的中空为白色的底图图片
+ (UIImage *)imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius withSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius withSize:(CGSize)size;

///获取bundle中图片资源文件的标准方式。主要是为了支持动态库获取图片资源的问题 aClass指podspec中的source class,模块化使用要特别注意检查
//+ (nullable UIImage *)imageNamed:(NSString *)name bundleName:(NSString *)bundleName forClass:(Class)aClass;


@end

NS_ASSUME_NONNULL_END
