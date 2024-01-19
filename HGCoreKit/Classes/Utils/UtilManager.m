//
//  UtilManager.m
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import "UtilManager.h"
#import "MachOSignature.h"
#import "HGDeviceInfoUtil.h"

@implementation UtilManager

+ (NSDictionary *)loadMach_OSignatureInfo {
    NSDictionary *dic = [MachOSignature loadSignature];
    return dic;
}

+ (NSInteger) getCanUseNetWorkType {
//    NSInteger netType = [HGDeviceInfoUtil getCurrentNetDataType];
    NSInteger netType = [HGDeviceInfoUtil getCurrentNetDataType_V2];

    return netType;
}

+ (NSString *) getMobileNetWorkType {
    NSString* netType = [HGDeviceInfoUtil getMobileNetType];

    return netType;
}


+(BOOL)isEmptyWithDicObj:(NSDictionary *_Nullable)dicObj {
    if ([dicObj isKindOfClass:[NSNull class]] || [dicObj isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

@end
