//
//  UIScreen+Ext.m
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import "UIScreen+Ext.h"
#import "UIApplication+Ext.h"

@implementation UIScreen (Ext)

- (BOOL)isiPhoneX{
    return [[UIScreen mainScreen] bounds].size.height >= 812.0f;
}

- (CGFloat)safeAreaHeight{
    return [self isiPhoneX] ? 34 : 0;
}

+ (UIWindow *)currentWindow {
    return [UIApplication displayWindow];
}

- (CGFloat)statusBarHeight{
    float statusBarHeight = 0;
    
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+(CGFloat)getTabBarHeight {
    return UITAB_HEIGHT;
}

+ (CGFloat)bottomSafeAreaHeight {
    UIWindow *keyWindow = [self currentWindow];
    UIEdgeInsets safeAreaInsets = keyWindow.safeAreaInsets;
    CGFloat saHeight = safeAreaInsets.bottom;
    
    return saHeight;
}

+(CGFloat)getTabBarHeight_V1 {
    return [self getTabBarHeight];
    
    UIViewController *topViewController = [UIApplication topViewController];
    UITabBar *tabBar = topViewController.tabBarController.tabBar;
    CGFloat tabBarHeight = tabBar.frame.size.height;
    
    return tabBarHeight;
}

+ (CGFloat)navigationBarHeight{
    return HGNAVIGATIONBAR_HEIGHT;
}

+ (CGFloat)statusBarHeight {
    return UISTATUS_BAR_HEIGHT;
}

+ (CGFloat)naviHeight {
    return UINAV_HEIGHT;
}

+ (CGFloat) getScreenWidth {
    return SCREEN_WIDTH;
}

+ (CGFloat) getScreenHeight {
    return SCREEN_HEIGHT;
}

//顶部安全区距离
+ (CGFloat)getTopSafeDistance {
    if (@available(iOS 13.0, *)) {
        
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        
        return window.safeAreaInsets.top;
    }
    return 0;
}

+ (CGFloat)getBottomSafeDistance  {
    if (@available(iOS 13.0, *)) {
        
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


@end
