//
//  HGCoreKitDefines.h
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#ifndef HGCoreKitDefines_h
#define HGCoreKitDefines_h


//字符串转换为非空
#define __String_Not_Nil(str) (str?:@"")

#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width //视图的宽
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height//视图的高

//状态栏高度
#define UISTATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
///#define UISTATUS_BAR_HEIGHT ([[UIScreen  mainScreen] statusBarHeight])

//Navigation高度
#define HGNAVIGATIONBAR_HEIGHT [UINavigationBar appearance].frame.size.height
//导航栏高度
///#define HGNAVIGATIONBAR_HEIGHT  44.0f

///状态栏高度+导航栏高度
#define UINAV_HEIGHT (UISTATUS_BAR_HEIGHT + HGNAVIGATIONBAR_HEIGHT)


//判断是否为iPhone Xz及以上的机型
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define is_iPhoneXS_Max (kScreenW ==414.f&& kScreenH ==896.f)
#define is_iPhoneX (kScreenW ==375.f&& kScreenH ==812.f)
#define is_iPhone8_Plus (kScreenW ==414.f&& kScreenH ==736.f)
#define is_iPhone8 (kScreenW ==375.f&& kScreenH ==667.f)
#define is_iPhone5 (kScreenW ==320&& kScreenH ==568.f)
#define is_iPhone5_OR_LESS (kScreenW ==320&& kScreenH <=568.f)


//tabbar的高度
#define kTabBarHeight [[UITabBarController alloc]init].tabBar.frame.size.height
#define UITAB_HEIGHT ([[UIScreen mainScreen] isiPhoneX] ? 83 : 49)

///底部安全距离
#define UITAB_SAFEDISTANCE ([[UIScreen mainScreen] isiPhoneX] ? 34 : 0)

//tabbar的高度(含iPhone X系列)
#define kTabBarHeight_X (IPHONE_X ? (kTabBarHeight + 34) : kTabBarHeight)

#define BlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

///strongify和weakify实现原理:https://www.cnblogs.com/chaoguo1234/p/16029469.html
//#define strongify_self(...) \
//    rac_keywordify \
//    _Pragma("clang diagnostic push") \
//    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
//    metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
//    _Pragma("clang diagnostic pop")
//
//#define weakify_self(...) \
//    rac_keywordify \
//    metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)




#endif /* HGCoreKitDefines_h */
