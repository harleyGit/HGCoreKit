//
//  UIImage+Ext.m
//  HGCoreKit
//
//  Created by GangHuang on 2023/7/20.
//

#import "UIImage+Ext.h"
#import "UIColor+Ext.h"

#import "TxtUtil.h"

static NSString *QiInputCorrectionLevelL = @"L";//!< L: 7%
static NSString *QiInputCorrectionLevelM = @"M";//!< M: 15%
static NSString *QiInputCorrectionLevelQ = @"Q";//!< Q: 25%
static NSString *QiInputCorrectionLevelH = @"H";//!< H: 30%

@implementation UIImage (Ext)

-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color {
    UIGraphicsBeginImageContext(size);
    // 获取当前上下文
    // 之后就可以在contextRef进行绘画
    CGContextRef contextRef =UIGraphicsGetCurrentContext();
    
    // 设置填充色
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    //context.setFillColor(color.cgColor)
    // 绘制填充指定区域
    CGContextFillRect(contextRef, CGRectMake(0, 0, size.width, size.height)); //联系显示区域
    
    // 获取图形上下文的内容
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    
    // 移除当前图形上下文,消除画笔
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)transformToSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (UIImage *)setupImgSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


// 生成二维码
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size {
    if([TxtUtil isEmptyWithTxt:code]){
        return [UIImage new];
    }
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    //  使用CIQRCodeGenerator创建filter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputCorrectionLevel": QiInputCorrectionLevelH}];
    // 由filter.outputImage直接转成的UIImage不太清楚，需要做高清处理
    UIImage *codeImage = [self scaleImage:filter.outputImage toSize:size];
    
    return codeImage;
}

// 合成图片（code+logo）
+ (UIImage *)combinateCodeImage:(UIImage *)codeImage andLogo:(UIImage *)logo {
    
    UIGraphicsBeginImageContextWithOptions(codeImage.size, YES, [UIScreen mainScreen].scale);
    
    // 将codeImage画到上下文中
    [codeImage drawInRect:(CGRect){.0, .0, codeImage.size.width, codeImage.size.height}];
    
    // 定义logo的绘制参数
    CGFloat logoSide = fminf(codeImage.size.width, codeImage.size.height) / 4;
    CGFloat logoX = (codeImage.size.width - logoSide) / 2;
    CGFloat logoY = (codeImage.size.height - logoSide) / 2;
    CGRect logoRect = (CGRect){logoX, logoY, logoSide, logoSide};
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:logoRect cornerRadius:logoSide / 5];
    [cornerPath setLineWidth:2.0];
    [[UIColor whiteColor] set];
    [cornerPath stroke];
    [cornerPath addClip];
    
    // 将logo画到上下文中
    [logo drawInRect:logoRect];
    
    // 从上下文中读取image
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return codeImage;
}


// 生成条形码
+ (UIImage *)generateCode128:(NSString *)code size:(CGSize)size {
    if([TxtUtil isEmptyWithTxt:code]){
        return [UIImage new];
    }
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    //  使用CICode128BarcodeGenerator创建filter
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputQuietSpace": @.0}];
    // 由filter.outputImage直接转成的UIImage不太清楚，需要做高清处理
    UIImage *codeImage = [self scaleImage:filter.outputImage toSize:size];
    
    return codeImage;
}



// 缩放图片(生成高质量图片）
+ (UIImage *)scaleImage:(CIImage *)image toSize:(CGSize)size {
    
    //! 将CIImage转成CGImageRef
    CGRect integralRect = image.extent;// CGRectIntegral(image.extent);// 将rect取整后返回，origin取舍，size取入
    CGImageRef imageRef = [[CIContext context] createCGImage:image fromRect:integralRect];
    
    //! 创建上下文
    CGFloat sideScale = fminf(size.width / integralRect.size.width, size.width / integralRect.size.height) * [UIScreen mainScreen].scale;// 计算需要缩放的比例
    size_t contextRefWidth = ceilf(integralRect.size.width * sideScale);
    size_t contextRefHeight = ceilf(integralRect.size.height * sideScale);
    CGContextRef contextRef = CGBitmapContextCreate(nil, contextRefWidth, contextRefHeight, 8, 0, CGColorSpaceCreateDeviceGray(), (CGBitmapInfo)kCGImageAlphaNone);// 灰度、不透明
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);// 设置上下文无插值
    CGContextScaleCTM(contextRef, sideScale, sideScale);// 设置上下文缩放
    CGContextDrawImage(contextRef, integralRect, imageRef);// 在上下文中的integralRect中绘制imageRef
    
    //! 从上下文中获取CGImageRef
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    
    //! 将CGImageRefc转成UIImage
    UIImage *scaledImage = [UIImage imageWithCGImage:scaledImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    return scaledImage;
}

#pragma mark - 通过颜色创建 UIImage

+ (UIImage *)imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithColorString:(NSString *)string
{
  return [self imageWithColor:[UIColor colorWithHexString:string]];
}

+ (UIImage *)imageWithColorString:(NSString *)string cornerRadius:(CGFloat)radius withSize:(CGSize)size
{
  return [self imageWithColor:[UIColor colorWithHexString:string] cornerRadius:radius withSize:size];
}

+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius withSize:(CGSize)size
{
  CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [color setFill];
  [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithColorString:(NSString *)string dash:(CGFloat *)dash withSize:(CGSize)size
{
  return [self imageWithColor:[UIColor colorWithHexString:string] dash:dash withSize:size];
}

+ (UIImage *)imageWithColor:(UIColor *)color dash:(CGFloat *)dash withSize:(CGSize)size
{
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [color setStroke];
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path setLineDash:dash count:2 phase:0];
  [path setLineWidth:size.height];
  [path moveToPoint:CGPointMake(0, 0)];
  [path addLineToPoint:CGPointMake(size.width, 0)];
  [path stroke];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

/// 可设置border的中空为白色的底图图片
+ (UIImage *)imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius withSize:(CGSize)size
{
  return [self imageWithColor:[UIColor whiteColor] borderColor:borderColor borderWidth:borderWidth cornerRadius:radius withSize:size];
}

+ (UIImage *)imageWithColor:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius withSize:(CGSize)size;
{
  if (!color) {
    color = [UIColor whiteColor];
  }
  
  if (!borderColor) {
    borderColor = [UIColor blackColor];
  }
  
  CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [borderColor setStroke];
  [color setFill];
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth/2.0 + 1, borderWidth/2.0 + 1) cornerRadius:radius];
  path.lineWidth = borderWidth;
  [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
  [path fill];
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}


@end
