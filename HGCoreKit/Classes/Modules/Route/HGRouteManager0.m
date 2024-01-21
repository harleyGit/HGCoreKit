//
//  HGRouteManager0.m
//  HGCoreKit
//
//  Created by Harley Huang on 21/1/2024.
//

#import "HGRouteManager0.h"

#import "HGBaseController.h"
#import "UIApplication+Ext.h"
#import "UIView+Ext.h"

@implementation HGRouteManager0

+ (UIViewController *)currentController {
    return  [UIApplication topOfRootViewController];
}

+ (void)navionOriginColer:(nullable HGBaseController *)originColer
                    parter:(id _Nullable)parter
             callBackBlock:(RouteCallBlock _Nullable)callBackBlock
               targetCName:(NSString *_Nullable)targetCName {
    if(!originColer){
        originColer = (HGBaseController *)[UIApplication topOfRootViewController];
    }
    
    [self routeType:RouteShowTypeNavigation
       originConler:originColer
             parter:parter
          backBlock:callBackBlock
         targetName:targetCName];
}

+ (void) routeWithType:(RouteShowType)routeType
                 parameter:(id _Nullable)parameter
             callBackBlock:(RouteCallBlock _Nullable)callBlock
      targetControllerName:(NSString *_Nullable)controllerName {
    
    HGBaseController *sourceController = (HGBaseController *)[UIApplication topOfRootViewController];
    
    [self routeType:routeType
       originConler:sourceController
              parter:parameter
          backBlock:callBlock
   targetName:controllerName];
    
}


+ (void) routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
  targetControllerName:(NSString *_Nullable)controllerName {
    [self routeWithType:routeType
             sourceView:view
              parameter:nil
          callBackBlock:nil
   targetControllerName:controllerName];
}

+ (void) routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
             parameter:(id _Nullable)parameter
  targetControllerName:(NSString *_Nullable)controllerName {
    [self routeWithType:routeType
             sourceView:view
              parameter:parameter
          callBackBlock:nil
   targetControllerName:controllerName];
}

+ (void) routeWithType:(RouteShowType)routeType
            sourceView:(UIView *)view
             parameter:(id _Nullable)parameter
         callBackBlock:(RouteCallBlock _Nullable)callBlock
  targetControllerName:(NSString *_Nullable)controllerName {
    
    HGBaseController *sourceController = (HGBaseController *)[UIView controllerOfView:view];
    
    [self routeType:routeType
       originConler:sourceController
              parter:parameter
          backBlock:callBlock
   targetName:controllerName];
}


+ (void)  routeType:(RouteShowType)routeType
      originConler:(HGBaseController *)controller
             parter:(id _Nullable)parameter
         backBlock:(RouteCallBlock _Nullable)callBlock
  targetName:(NSString *_Nullable)targetControllerName {
    
    Class class = NSClassFromString(targetControllerName);
    SEL sel = NSSelectorFromString(@"setupRouteParameter:callBack:");
    HGBaseController *tarConer = [[class alloc] initWithParter:parameter];

    // 检查对象是否响应这个方法
    if ([tarConer respondsToSelector:sel]) {
        // 创建一个 NSInvocation 对象
        NSMethodSignature *signature = [tarConer methodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        
        // 设置方法选择器
        [invocation setSelector:sel];
        
        // 设置参数值
        id param1 = parameter;
        RouteCallBlock param2 = callBlock;

        // 参数的索引从2开始
        //因为索引0和1分别用于方法的选择器和目标对象
        [invocation setArgument:&param1 atIndex:2];
        // 在块中使用 weakSelf，而不是 myObject
        [invocation setArgument:&param2 atIndex:3];
        
        // 调用方法
        [invocation invokeWithTarget:tarConer];
    } else {
        // 方法不存在或不可响应
        DLog(@"Method %@ not found or not supported by the object.", NSStringFromSelector(sel));
    }
    
    switch (routeType) {
        case RouteShowTypeNavigation:
            [controller.navigationController pushViewController:tarConer animated:YES];
            break;
        case  RouteShowTypePresent:
            [controller presentViewController:tarConer animated:YES completion:nil];
            break;
        case  RouteShowTypeTab:
            break;
        default:
            break;
    }
}

@end
