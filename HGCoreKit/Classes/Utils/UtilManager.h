//
//  UtilManager.h
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilManager : NSObject

/// 加载本地mach签名信息
+ (NSDictionary *)loadMach_OSignatureInfo;

/// 可以使用的网络类型: 1 飞行, 2 wifi, 4 数据, 6 wifi+数据
+ (NSInteger) getCanUseNetWorkType;

+ (NSString *) getMobileNetWorkType;

/// 字典是否为空
/// @param dicObj 字典对象
+(BOOL)isEmptyWithDicObj:(NSDictionary *_Nullable)dicObj;
@end

NS_ASSUME_NONNULL_END
