//
//  HGSectionModel.m
//  MLC
//
//  Created by Harley Huang on 10/6/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//

#import "HGSectionModel.h"

@implementation HGSectionModel

///优势:不需要导入BaseCollectionCellM类头文件
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"cells": @"BaseCollectionCellM",
    };
}

@end
