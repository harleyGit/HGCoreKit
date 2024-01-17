//
//  LogUtil.h
//  HGCoreKit
//
//  Created by Harley Huang on 17/1/2024.
//

#import <Foundation/Foundation.h>

#define WEAKSELF_KM __weak __typeof(&*self)weakSelf = self;

#ifdef DEBUG

#define DLog(...)  [LogUtil debugLog:__VA_ARGS__];

#else

#define DLog(...)  while(0) {}

#endif

NS_ASSUME_NONNULL_BEGIN

@interface LogUtil : NSObject


#pragma mark -- 日志方法
// 设置日志输出状态
+ (void)setLogEnable:(BOOL)enable;

// 获取日志输出状态
+ (BOOL)getLogEnable;

// 日志输出方法
+ (void)customLogWithFunction:(const char *)function lineNumber:(int)lineNumber formatString:(NSString *)formatString;

+ (void)debugLog:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);



@end

NS_ASSUME_NONNULL_END
