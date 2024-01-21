//
//  UIFont+Ext.h
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Ext)

+ (UIFont *)fontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldFontOfSize:(CGFloat)fontSize;

+ (UIFont *)charFontOfSize:(CGFloat)fontSize;
+ (UIFont *)charBoldFontOfSize:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
