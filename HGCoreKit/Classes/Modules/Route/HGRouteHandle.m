//
//  HGRouteHandle.m
//  HGCoreKit
//
//  Created by Harley Huang on 21/1/2024.
//

#import "HGRouteHandle.h"

@implementation HGRouteHandle

+ (NSArray *)getAuthArr {
    return @[@"ScanController", @"HardwareHandle"];
}

+(void)modalCConler:(UIViewController *)cconler
             parter:(id _Nullable)parter
        targetCName:(NSString *)targetCName
      completeBlock:(nullable RouteCallBlock)completeBlock {
    
//    if([[self getAuthArr] containsObject:targetCName]){
//        [self authInteptWithCConler:cconler
//                           showType:RouteShowTypeNavigation
//                             parter:parter
//                        targetCName:targetCName
//                      completeBlock:completeBlock];
//        return;
//    }
}

+(void)navTargetCName:(NSString *)targetCName {
    [self navCConler:nil
              parter:nil
         targetCName:targetCName
           backBlock:nil];
}

+(void)navParter:(id _Nullable)parter
     targetCName:(NSString *)targetCName {
    [self navCConler:nil
              parter:parter
         targetCName:targetCName
           backBlock:nil];
}

+(void)navCConler:(UIViewController *)cconler
      targetCName:(NSString *)targetCName {
    [self navCConler:cconler
              parter:nil
         targetCName:targetCName
           backBlock:nil];
}

+(void)navCConler:(UIViewController *)cconler
           parter:(id _Nullable)parter
      targetCName:(NSString *)targetCName {
    
    [self navCConler:cconler
              parter:parter
         targetCName:targetCName
           backBlock:nil];
}

+(void)navCConler:(nullable UIViewController *)cconler
           parter:(id _Nullable)parter
      targetCName:(NSString *)targetCName
        backBlock:(RouteCallBlock _Nullable)backBlock {
    if([[self getAuthArr] containsObject:targetCName]){
//        [self authInteptWithCConler:cconler
//                           showType:RouteShowTypeNavigation
//                             parter:parter
//                        targetCName:targetCName
//                      completeBlock:backBlock];
//        return;
    }
    
    [self navionOriginColer:(HGBaseController *)cconler
                     parter:parter
              callBackBlock:backBlock
                targetCName:targetCName];
}

/*
+ (BOOL)authInteptWithCConler:(UIViewController *)cconler
                     showType:(RouteShowType)routeType
                       parter:(id _Nullable)parter
                  targetCName:(NSString *)targetCName
                completeBlock:(RouteCallBlock)completeBlock
                          {
    //XCQRCodeVC, type: SGPermissionTypeCamera
    NSDictionary *parDic = (NSDictionary *)parter;
    NSUInteger type = [parDic[@"type"] integerValue];
    
    [SGPermission permissionWithType:type completion:^(SGPermission * _Nonnull permission, SGPermissionStatus status) {
        if (status == SGPermissionStatusNotDetermined) {
            [permission request:^(BOOL granted) {
                if (granted) {
                    NSLog(@"第一次授权成功");
                    if(type == SGPermissionTypePhoto){
                        [HardwareHandle albumWithOriginConler:cconler
                                                completeBlock:completeBlock];
                        return;
                    }
                    
                    [self navionOriginColer:cconler
                                     parter:parter
                              callBackBlock:completeBlock
                                targetCName:targetCName];
                } else {
                    NSLog(@"第一次授权失败");
                }
            }];
        } else if (status == SGPermissionStatusAuthorized) {
            if(type == SGPermissionTypePhoto){
                [HardwareHandle albumWithOriginConler:cconler
                                        completeBlock:completeBlock];
                return;
            }
            
            [self navionOriginColer:cconler
                             parter:parter
                      callBackBlock:completeBlock
                        targetCName:targetCName];
        } else if (status == SGPermissionStatusDenied) {
            [self systemAuthFailedWitController:cconler];
        } else if (status == SGPermissionStatusRestricted) {
            [self systemAuthUnknownWitController:cconler];
        }
    }];
    
    return YES;
}


+ (BOOL)systemAuthInterceptWithSouceController:(UIViewController *)scontroller
                                     parameter:(id _Nullable)parameter
                                controllerName:(NSString *)controllerName {
    
    [self authInteptWithCConler:scontroller
                       showType:RouteShowTypeNavigation
                         parter:parameter
                    targetCName:controllerName
                  completeBlock:nil];
    return YES;
}

+ (void)systemAuthFailedWitController:(UIViewController *)controller {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"[前往：设置 - 隐私 - 相机 - SGQRCode] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertC addAction:alertA];
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alertC animated:YES completion:nil];
    });
}

+ (void)systemAuthUnknownWitController:(UIViewController *)controller  {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alertC animated:YES completion:nil];
    });
}
*/

+ (BOOL)routeIntercep{
//    if([[ConfigHandle shareInstance] isTokenInfoValid]){
//        //跳转到登录页面
//        return YES;
//    }
    
    return NO;
}

@end
