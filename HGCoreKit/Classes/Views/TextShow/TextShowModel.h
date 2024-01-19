//
//  TextShowModel.h
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/15.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TextShowModel : NSObject

//文字内容的实际高度
@property (nonatomic, assign) CGFloat titleActualH;

//文字内容的最大高度，具体的数值是 一行文本的高度*期望的最大显示行数
@property (nonatomic, assign) CGFloat titleMaxH;

//内容是否展开（默认不设置，都是NO，收起状态）
@property (nonatomic, assign) BOOL isOpen;

@property(nonatomic, copy)NSString *content;


@end

NS_ASSUME_NONNULL_END
