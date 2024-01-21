//
//  UIFont+Ext.m
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import "UIFont+Ext.h"

@implementation UIFont (Ext)

+ (UIFont *)fontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:GlobalFontName0 size:fontSize];
}

+ (UIFont *)boldFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:GlobalFontName5 size:fontSize];
}

+ (UIFont *)charFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"GillSans" size:fontSize];
}

+ (UIFont *)charBoldFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"GillSans-Boldtalic" size:fontSize];
}

@end
