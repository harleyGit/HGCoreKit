//
//  HGSectionModel.h
//  MLC
//
//  Created by Harley Huang on 10/6/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//
/// MJExtension:模型中装数组,数组中又有其他模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BaseCCellProtocol;

@interface HGSectionModel : NSObject

/// section标题
@property(nonatomic, copy)NSString *sectionTitle;
@property(nonatomic, copy)NSMutableArray<id <BaseCCellProtocol>> *cells;;

@end

NS_ASSUME_NONNULL_END
