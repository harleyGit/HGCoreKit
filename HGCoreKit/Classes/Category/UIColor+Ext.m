//
//  UIColor+Ext.m
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import "UIColor+Ext.h"

UIColor *COLOR_RGB(NSUInteger r, NSUInteger g, NSUInteger b){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

UIColor *COLOR_RGB_V1(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat alpha){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

@implementation UIColor (Ext)


+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    if (hexString.length == 0){
        return [UIColor clearColor];
    }
    
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)decimal16_rgbValue:(NSUInteger)rgbValue {//0xf0f0f0
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0];
}


+ (UIColor *)randomColor {
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) + 0.5;
    CGFloat brightness = (arc4random() %128/256.0) + 0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

+ (nullable UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha {
    if (@available(iOS 10.0, *)) {
        return [UIColor
                colorWithDisplayP3Red:((float)((hexValue & 0xFF0000) >> 16))/255.0
                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                blue:((float)(hexValue & 0xFF))/255.0
                alpha:alpha];
    } else {
        return [UIColor
                colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                blue:((float)(hexValue & 0xFF))/255.0
                alpha:alpha];
    }
}

+ (nullable UIColor *)colorWithARGBHexValue:(uint)hexValue {
    if (@available(iOS 10.0, *)) {
        return [UIColor
                colorWithDisplayP3Red:((float)((hexValue & 0xFF0000) >> 16))/255.0
                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                blue:((float)(hexValue & 0xFF))/255.0
                alpha:((float)((hexValue & 0xFF000000) >> 24))/255.0];
    } else {
        return [UIColor
                colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                green:((float)((hexValue & 0xFF00) >> 8))/255.0
                blue:((float)(hexValue & 0xFF))/255.0
                alpha:((float)((hexValue & 0xFF000000) >> 24))/255.0];
    }
}

+ (nullable UIColor *)colorWithHexString:(NSString*)hexString alpha:(float)alpha {
    if (hexString == nil || (id)hexString == [NSNull null]) {
        return nil;
    }
    UIColor *col;
    if (![hexString hasPrefix:@"#"]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        col = [self colorWithHexValue:hexValue alpha:alpha];
    } else {
        // invalid hex string
        col = [UIColor clearColor];
    }
    return col;
}

+ (nullable UIColor *)colorWithARGBHexString:(NSString *)hexString {
    if (hexString == nil || (id)hexString == [NSNull null]) {
        return nil;
    }
    if (![hexString hasPrefix:@"#"]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        return [self colorWithARGBHexValue:hexValue];
    } else {
        return [UIColor clearColor];
    }
}

+ (nullable UIColor *) colorWithHexString: (NSString*) hexStr
{
    NSArray *hexArray = [hexStr componentsSeparatedByString:@"-"];
    if (hexArray.count==2) {
        return [self colorWithHexString:hexArray[0] alpha:[hexArray[1] floatValue]/100.0f];
    } else if (hexArray.count==1 && [hexArray[0] length] >= 8) {
        return [self colorWithARGBHexString:hexStr];
    } else {
        return [self colorWithHexString:hexStr alpha:1.0f];
    }
}

- (NSString *)hexString {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha && self.alpha < 1) {
        hex = [hex stringByAppendingFormat:@"-%zd",
               (unsigned long)(self.alpha * 100)];
    }
    return hex;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}


@end
