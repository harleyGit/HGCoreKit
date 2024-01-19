//
//  HGDeviceInfoUtil.h
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, NetDataType) {//位运算:https://www.jianshu.com/p/9ac1397b5e98, iOS位运算: https://juejin.cn/post/6946501324964003847
    NetDataTypeNone         = 0 << 0, // 0000 0
    NetDataTypeFlightMode   = 1 << 0, // 0001 1
    NetDataTypeWIFI         = 1 << 1, // 0010 2
    NetDataTypeMobileData   = 1 << 2, // 0100 4
};

@interface HGDeviceInfoUtil : NSObject


/// 获取目前网络数据类型
+ (NetDataType)getCurrentNetDataType;

/// 获取目前网络数据类型 v2
/// 1 飞行模式, 2 Wi-Fi, 4 数据, 6 Wi-Fi+数据
+ (NetDataType)getCurrentNetDataType_V2;

/// 获取WIFI地址
+ (NSString *)na_ipAddressWIFI;
/// 获取移动数据地址
+ (NSString *)na_ipAddressCell;


/// 获取移动数据类型
+ (NSString *)getMobileNetType;

@end

NS_ASSUME_NONNULL_END
