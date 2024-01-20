//
//  NSArray+Safe.m
//  MLC
//
//  Created by Harley Huang on 9/5/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSArray (Safe)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSArray swizzleClassMethod:@selector(arrayWithObject:) withMethod:@selector(hookArrayWithObject:)];
    });
}


+ (instancetype) hookArrayWithObject:(id)anObject{
    if (anObject) {
        return [self hookArrayWithObject:anObject];
    }
    
    DLog(@"初始化数组错误了!!!");
    return nil;
}



@end
