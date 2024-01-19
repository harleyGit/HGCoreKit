//
//  UIImage+Color.m
//  AccModuleSDK
//
//  Created by GangHuang on 2023/7/20.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

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

@end
