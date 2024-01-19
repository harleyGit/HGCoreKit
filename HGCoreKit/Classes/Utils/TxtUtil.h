//
//  TxtUtil.h
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TxtUtil : NSString

+ (BOOL)isEmptyWithTxt:(NSString *)txt;

/// 富文本+图片
/// @param txt 文本
/// @param picName 图片名称
+ (NSMutableAttributedString *)richTxtWithTxt:(NSString *)txt
                                      picName:(NSString *)picName;
@end

NS_ASSUME_NONNULL_END
