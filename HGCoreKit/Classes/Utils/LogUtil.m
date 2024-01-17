//
//  LogUtil.m
//  HGCoreKit
//
//  Created by Harley Huang on 17/1/2024.
//  https://blog.csdn.net/iOS1501101533/article/details/108494049

#import "LogUtil.h"

@implementation LogUtil

// 默认值为NO
static BOOL kLogEnable = NO;

// 设置日志输出状态
+ (void)setLogEnable:(BOOL)enable {
    kLogEnable = enable;
}

// 获取日志输出状态
+ (BOOL)getLogEnable {
    return kLogEnable;
}

// 日志输出方法
+ (void)customLogWithFunction:(const char *)function lineNumber:(int)lineNumber formatString:(NSString *)formatString {
    if ([self getLogEnable]) {
        // 开启了Log
        NSLog(@"☘️ %@", formatString);
    }
}

+ (void)debugLog:(NSString *)format, ... {
  @autoreleasepool {
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"%@", str);
    va_end(args);
  }
}

@end
