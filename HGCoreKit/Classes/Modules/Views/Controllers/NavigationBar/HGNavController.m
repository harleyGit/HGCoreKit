//
//  HGNavController.m
//  HGCoreKit
//
//  Created by GangHuang on 11/22/23.
//  Copyright © 2023 com.HuangGang.CoreKit. All rights reserved.
//

#import "HGNavController.h"

@interface HGNavController ()
//<UINavigationControllerDelegate>

@end

@implementation HGNavController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        if (@available(iOS 15.0, *)) {
            //适配在iOS 15导航栏无背景颜色
            UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
            // appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
            // appearance.backgroundColor = [UIColor colorWithRed:13/255.0f green:19/255.0f blue:25/255.0f alpha:1.0f];;
            appearance.shadowImage = nil;
            appearance.shadowColor = nil;
            appearance.backgroundImage = [UIImage imageNamed:@"nav_bar_bg"];
            
            self.navigationBar.scrollEdgeAppearance = appearance;
            self.navigationBar.standardAppearance = appearance;
            self.navigationBar.compactAppearance = appearance;
            //self.navigationBar.compactScrollEdgeAppearance = appearance;//高系统版本属性
            
            // iOS15系统 防止页面滑动的时候出现空白(刷新机制改变,取消预取)
            //[[UITableView appearance] setPrefetchingEnabled:NO];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
