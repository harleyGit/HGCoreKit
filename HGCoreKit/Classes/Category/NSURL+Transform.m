//
//  NSURL+Transform.m
//  GloudGame
//
//  Created by GangHuang on 2023/8/3.
//

#import "NSURL+Transform.h"
#import <objc/runtime.h>//必须导入,否则Method类不知其定义


@implementation NSURL (Transform)


+(void)load{
    Method originMethod = class_getClassMethod([self class], @selector(URLWithString:));
    Method changeMethod = class_getClassMethod([self class], @selector(pk_UTF8URLWithString:));
    method_exchangeImplementations(originMethod, changeMethod);
}

+ (NSURL *)pk_UTF8URLWithString:(NSString *)urlString{
    if ([self hasChinese:urlString] == YES) {
        NSString *url = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL * resultURL = [NSURL pk_UTF8URLWithString:url];
        return resultURL;
    }else{
        NSURL * resultURL = [NSURL pk_UTF8URLWithString:urlString];
        return resultURL;
    }
}

+ (BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
