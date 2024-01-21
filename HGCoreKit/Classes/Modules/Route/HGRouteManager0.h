//
//  HGRouteManager0.h
//  HGCoreKit
//
//  Created by Harley Huang on 21/1/2024.
//

#import <Foundation/Foundation.h>


///页面展示方式
typedef NS_ENUM(NSInteger, RouteShowType) {
    RouteShowTypeNavigation = 0, //路由
    RouteShowTypePresent,        //模态
    RouteShowTypeTab,            //tab点击
};
typedef void(^RouteCallBlock)(id _Nullable argument);


NS_ASSUME_NONNULL_BEGIN

@class HGBaseController;

@interface HGRouteManager0 : NSObject

+ (UIViewController *)currentController;
/// 导航路由
/// - Parameters:
///   - originColer: 源视图控制器
///   - parter: 参数
///   - callBackBlock: 回调
///   - targetCName: 目标控制器类名
+ (void)navionOriginColer:(nullable HGBaseController *)originColer
                   parter:(id _Nullable)parter
            callBackBlock:(RouteCallBlock _Nullable)callBackBlock
              targetCName:(NSString *_Nullable)targetCName;

+ (void)routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
  targetControllerName:(NSString *_Nullable)controllerName;

+ (void)routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
             parameter:(id _Nullable)parameter
  targetControllerName:(NSString *_Nullable)controllerName;

/// 视图导航到视图控制器
/// - Parameters:
///   - routeType: 路由类型
///   - view: 视图
///   - parameter: 参数
///   - callBlock: 回调bloc
///   - controllerName: 目标视图控制器
+ (void) routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
             parameter:(id _Nullable)parameter
         callBackBlock:(RouteCallBlock _Nullable)callBlock
  targetControllerName:(NSString *_Nullable)controllerName;

@end

NS_ASSUME_NONNULL_END
