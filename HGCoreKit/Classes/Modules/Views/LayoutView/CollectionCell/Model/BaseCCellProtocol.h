//
//  BaseCCellProtocol.h
//  KIWComSDK
//
//  Created by GangHuang on 9/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///cell的这个协议最好可以携带错误,比如:errrMsg,其他不要
///model可以遵守这个协议,也可以不遵守
@protocol BaseCCellProtocol <NSObject>

/// cell标题
@property(nonatomic, copy)NSString *title;
/// cell索引
@property(nonatomic, assign)NSInteger index;
/// cell高度
@property(nonatomic, assign)CGSize cellSize;

@end

NS_ASSUME_NONNULL_END
