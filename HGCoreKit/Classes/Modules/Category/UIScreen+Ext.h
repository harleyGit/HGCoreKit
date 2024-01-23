//
//  UIScreen+Ext.h
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (Ext)

+ (UIWindow *)currentWindow;

- (BOOL)isiPhoneX;

/// 导航栏高度
+ (CGFloat)navigationBarHeight;

+ (CGFloat)naviHeight;

/// 屏幕宽度
+ (CGFloat) getScreenWidth;

/// 屏幕高度
+ (CGFloat) getScreenHeight;

/// 顶部安全区距离
+ (CGFloat)getTopSafeDistance;

/// 底部安全区距离
+ (CGFloat)getBottomSafeDistance;

+(CGFloat)getTabBarHeight __deprecated_msg("This method is deprecated. Use the getTabBarHeight_V1 instead.");
/// 获取底部tabBar高度
+(CGFloat)getTabBarHeight_V1;

@end

NS_ASSUME_NONNULL_END
