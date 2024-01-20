//
//  NSObject+HGRuntime.h
//
//  Created by GangHuang on 2019/2/7.
//  Copyright © 2019年 GangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HGRuntime)

/**
 *  将 ’字典数组’ 转换成当前模型的对象数组
 *
 *  @param array 字典数组
 *
 *  @return 模型对象数组
 */
+ (NSArray *)hg_objectsWithArray:(NSArray *)array;

/**
 *  返回当前类的所有属性
 *
 *  @return 属性名称的数组
 */
+ (NSArray *)hg_propertiesList;

/**
 *  返回当前类的所有成员变量的属性
 *
 *  @return 成员变量的数组
 */
+ (NSArray *)hg_ivarsList;

@end
