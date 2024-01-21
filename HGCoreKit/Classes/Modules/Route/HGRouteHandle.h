//
//  HGRouteHandle.h
//  HGCoreKit
//
//  Created by Harley Huang on 21/1/2024.
//

#import "HGRouteManager0.h"

NS_ASSUME_NONNULL_BEGIN

@interface HGRouteHandle : HGRouteManager0

+(void)navTargetCName:(NSString *)targetCName;

+(void)navParter:(id _Nullable)parter
     targetCName:(NSString *)targetCName;

+(void)navCConler:(UIViewController *)cconler
      targetCName:(NSString *)targetCName;

+(void)navCConler:(UIViewController *)cconler
           parter:(id _Nullable)parter
      targetCName:(NSString *)targetCName;

/// 导航视图路由
/// - Parameters:
///   - cconler: 当前视图控制器
///   - parter: 下一个控制参数
///   - targetCName: 目标控制器名字
///   - backBlock: 路由回调
+(void)navCConler:(nullable UIViewController *)cconler
           parter:(id _Nullable)parter
      targetCName:(NSString *)targetCName
        backBlock:(RouteCallBlock _Nullable)backBlock;

/// 模态视图路由
/// - Parameters:
///   - modalCConler: 当前视图控制器
///   - parameter: 参数
///   - targetCName: 目标控制器名字
///   - completeBlock: 路由回调
+(void)modalCConler:(UIViewController *)cconler
             parter:(id _Nullable)parter
        targetCName:(NSString *)targetCName
      completeBlock:(nullable RouteCallBlock)completeBlock;


@end

NS_ASSUME_NONNULL_END
