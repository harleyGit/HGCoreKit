//
//  BaseController.m
//  Demo
//
//  Created by GangHuang on 2023/7/20.
//
/// 导航栏透明问题:https://www.cnblogs.com/eric-zhangy1992/p/15571539.html

#import "BaseController.h"
#import "UIImage+Ext.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNav];
}


- (void)configNav {
    /// 如果所有的 ChildViewController 都继承于 BaseViewController，且想在 viewDidLoad 中统一设置导航栏的『左按钮』，
    /// 那么，只能设置 backBarButtonItem ，而不能设置 leftBarButtonItem，原因如下：
    ///
    /// previousVC 是上一个页面，nextVC 是下一个页面，当发生 push 时，有如下规则：
    /// 1、如果 nextVC 的 leftBarButtonItem != nil，那么将在 navigationBar 的左边显示 nextVC 指定的 leftBarButtonItem；
    /// 2、如果 nextVC 的 leftBarButtonItem == nil，previousVC 的 backBarButtonItem != nil，那么将在 navigationBar 的左边显示 previousVC 指定的 backBarButtonItem；
    /// 3、如果两者都为 nil 则：
    ///   3.1、nextVC 的 navigationItem.hidesBackButton = YES，那么 navigationBar 将隐藏左侧按钮；
    ///   3.2、否则 navigationBar的左边将显示系统提供的默认返回按钮；
    ///
    /// 我们从以上规则中发现：
    /// 1、leftBarButtonItem 的优先级比 backBarButtonItem 要高；
    /// 2、backBarButtonItem 是来自上一个页面，如果当前 VC 是第一个页面，那么它没有上一个页面，也就没有 backBarButtonItem；
    /// 3、leftBarButtonItem 是来自当前页面，与上个页面无关，因此，如果当前 VC 是第一个页面，那么设置了 leftBarButtonItem 就会很奇怪；
    ///
    if (@available(iOS 16.0, *)) {
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" image:[UIImage new] target:self action:nil menu:nil];
    } else {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" menu:nil];
    }
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    // 设置导航栏背景为透明色图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏阴影为透明色图片
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    [self customNavBarWithBackgroundColor:[UIColor whiteColor]];
}

- (void) customNavBarWithBackgroundColor:(UIColor *_Nullable)color {
    color = color ?: [UIColor clearColor];
    //设置导航栏背景
    CGSize size = CGSizeMake(self.view.frame.size.width, 90);
    UIView *navBarV = [[UIImageView alloc] initWithImage: [[UIImage alloc] initWithSize:size color:[UIColor clearColor]]];
    [self.view addSubview:navBarV];
}



@end
