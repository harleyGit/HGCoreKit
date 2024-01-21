//
//  PublicMethods.h
//  MLC
//
//  Created by Harley Huang on 9/5/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//

#import "PublicMethods.h"

#ifndef PublicMethods_h
#define PublicMethods_h


//#define SafeAssert(condition, ...) \
//if (!(condition)){ WMSafeLog(__FILE__, __FUNCTION__, __LINE__, __VA_ARGS__);} \
//
//void SafeLog(const char* _Nullable file, const char* _Nullable func, int line, NSString* _Nullable fmt, ...);

void swizzleClassMethod(Class _Nonnull cls, SEL _Nonnull origSelector, SEL _Nonnull newSelector);

void swizzleInstanceMethod(Class _Nonnull cls, SEL _Nonnull origSelector, SEL _Nonnull newSelector);




#endif /* PublicMethods_h */
