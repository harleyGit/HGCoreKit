//
//  HGContant.h
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import <Foundation/Foundation.h>

///UIKIT_EXTERN关键字是OC中苹果推荐的引用外部变量的关键字,
///实际就是extern关键字的OC优化,作用和extern一致,引用外部变量需要的关键字
///全局UI上、左、下、右的Margin值
UIKIT_EXTERN const CGFloat GlobalMarginTop;
UIKIT_EXTERN const CGFloat GlobalMarginLeft;
UIKIT_EXTERN const CGFloat GlobalMarginBottom;
UIKIT_EXTERN const CGFloat GlobalMarginRight;



/// 字体样式,由粗到细
/// 苹果自带样式:https://www.jianshu.com/p/f4402f4eae3a
UIKIT_EXTERN NSString* _Nullable const GlobalFontName0;
UIKIT_EXTERN NSString* _Nullable const GlobalFontName1;
UIKIT_EXTERN NSString* _Nullable const GlobalFontName2;
UIKIT_EXTERN NSString* _Nullable const GlobalFontName3;
UIKIT_EXTERN NSString* _Nullable const GlobalFontName4;


/// 网络请求回调
typedef void(^CompleteCallBack) (BOOL isSuccess, id _Nullable data);

///FOUNDATION_EXPORT声明常量:https://juejin.cn/post/7089744654685929503
FOUNDATION_EXPORT NSString * const TEST_NOTIFY_NAME;

NS_ASSUME_NONNULL_BEGIN

@interface HGContant : NSObject

/// 默认左边距
+(CGFloat)leftMargin;
/// 默认右边距
+(CGFloat)RightMargin;

#pragma mark -- WX
/// 微信baseURL
+ (NSString *)wxBaseURL;
//注册时得到的AppSecret
+ (NSString *)wxKmetaAppSecret;
// 注册微信时的AppID
+ (NSString *)wxKmetaAppID;
/// 微信TOKEN
+ (NSString *)WX_ACCEESS_TOKEN_KEY;
+ (NSString *)WX_OPEN_ID_KEY;
+ (NSString *)WX_REFRESH_TOKEN_KEY;
+ (NSString *)WX_UNION_ID_KEY;
+ (NSString *) bundleDocumentName:(NSString *)name;

/// 获取图片格式后缀名
/// - Parameter picData: picData description
+ (NSString *_Nullable)transformPictureSuffixWithData:(NSData *)picData;

@end

NS_ASSUME_NONNULL_END
