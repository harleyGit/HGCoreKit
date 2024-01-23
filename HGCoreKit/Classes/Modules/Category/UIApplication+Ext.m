//
//  UIApplication+Ext.m
//  StarterApp
//
//  Created by js on 2019/6/17.
//  Copyright © 2019 js. All rights reserved.
//

#import "UIApplication+Ext.h"
#import "UIViewController+Child.h"
#import "UIScreen+Ext.h"

@implementation UIApplication (Ext)

+ (CGFloat)statusBarHeight {
    CGFloat statusBarHeight = 0;

    if (@available(iOS 13.0, *)) {
        statusBarHeight = [[[UIApplication sharedApplication] keyWindow] windowScene].statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    
    return statusBarHeight;
}

+ (CGFloat)bottomSafeAreaHeight {
    CGFloat bottomSafeAreaHeight = 0;

    if (@available(iOS 11.0, *)) {
        bottomSafeAreaHeight = [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom;
    }
    return bottomSafeAreaHeight;
}


+ (UIViewController *)displayViewController{
    return [self displayViewController:[self displayWindow].rootViewController ignorePresent:NO];
}

// add不忽略模态化
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    UIWindow *keyWindow = [self displayWindow];
    
    resultVC = [self _topViewController:[keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)displayViewController:(id)currentViewController ignorePresent:(BOOL)ignorePresent{
    if ([currentViewController isKindOfClass:[UINavigationController class]]){
        return [self displayViewController:[[currentViewController viewControllers] lastObject] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UITabBarController class]]){
        return [self displayViewController:[currentViewController selectedViewController] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UIViewController class]]) {
        UIViewController *presentedViewController = [currentViewController presentedViewController];
        if (ignorePresent == NO && presentedViewController && [[self blackListForDisplayPresentViewController] containsObject:NSStringFromClass([presentedViewController class])] == NO) {
            return [self displayViewController:[currentViewController presentedViewController] ignorePresent:ignorePresent];
        }else{
            UIViewController *displayChild = [(UIViewController *)currentViewController displayChildViewController];
            if (displayChild){
                if ([displayChild isKindOfClass:[UINavigationController class]] || [displayChild isKindOfClass:[UITabBarController class]]){
                    return [self displayViewController:displayChild ignorePresent:ignorePresent];
                } else {
                    return displayChild;
                }
            }
                
            return currentViewController;
        }
    }else{
        return nil;
    }
}

+ (NSString *)displayPageName{
    UIViewController *vc = [UIApplication displayViewController];
    SEL selector = NSSelectorFromString(@"pageName");
    if ([[vc class]respondsToSelector:selector]) {
        NSString *pageName = ((NSString * (*)(id, SEL))[[vc class] methodForSelector:selector])([vc class], selector);
        return pageName;
    }else{
        return NSStringFromClass([vc class]);
    }
}

+ (NSArray *)blackListForDisplayPresentViewController{
    static NSArray *whiteList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        whiteList = @[
                      @"RCTModalHostViewController",
                      ];
    });
    
    return whiteList;
}

+ (UIWindow *)displayWindow{
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene * windowScene in UIApplication.sharedApplication.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive){
                for (UIWindow * subWindow in windowScene.windows) {
                    if(subWindow.isKeyWindow){
                        window = subWindow;
                    }
                }
            }
        }
    }else{
        window = [self rootWindow];
    }
    return window;
}

+ (UIWindow *)rootWindow{
    __block UIWindow *window = nil;
    [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIWindow class]]) {
            window = obj;
        }
    }];
    return window;
}

+ (UIViewController *)topOfRootViewController{
    return [self displayViewController:[self displayWindow].rootViewController ignorePresent:YES];
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)nextHigherLeveViewController{
    UINavigationController * viewController =  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UITabBarController * tabbar = viewController.viewControllers.lastObject;
    UINavigationController * tabNa = [tabbar.viewControllers objectAtIndex:tabbar.selectedIndex];
    UIViewController * top = tabNa.viewControllers.lastObject;
    return top;
}

@end
