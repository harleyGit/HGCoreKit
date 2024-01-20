//
//  BaseReusableViewM.h
//  MLC
//
//  Created by Harley Huang on 12/12/2022.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HGBaseActionModel;

@interface BaseReusableViewM : NSObject

/// 标题
@property(nonatomic, copy)NSString *title;
/// 错误提示
@property(nonatomic, copy)NSString *errMsg;

@end

NS_ASSUME_NONNULL_END
