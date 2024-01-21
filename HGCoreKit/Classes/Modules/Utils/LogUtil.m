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
+ (void)customLogWithFunction:(const char *)function
                   lineNumber:(int)lineNumber
                 formatString:(NSString *)formatString {
    if ([self getLogEnable]) {
        // 开启了Log
        NSLog(@"☘️ %@", formatString);
    }
}

+ (void)debugLog:(NSString *)format, ... {
    @autoreleasepool {
        //这是一个用于处理变参参数的 va_list 类型的变量
        va_list args;
        
        //这个宏会初始化 va_list 类型的变量，使其指向参数列表中的第一个变参。
        //在这里，它将 args 初始化为指向 format 后的第一个变参
        va_start(args, format);
        
        NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
        NSLog(@"%@", str);
        
        //这个宏用于清理 va_list，在使用 va_start 初始化后，必须调用 va_end 来确保资源被正确释放
        va_end(args);
    }
}



@end
