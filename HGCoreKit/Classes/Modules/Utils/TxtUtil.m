//
//  TxtUtil.m
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import "TxtUtil.h"

#import "UIFont+Ext.h"


@implementation TxtUtil

+ (BOOL)isEmptyWithTxt:(NSString *)txt {
    if (!txt) {//声明变量,未设置初始值判断
        return YES;
    }
    
    //从后台请求回来数据进行JSON解析的时候, 如果解析出的NSDictionary中某个key对应的value为空,
    //则系统会把它处理为NSNull类的单例对象(因为NSArray和NSDictionary中都不能存储nil).
    if ([txt isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (!txt.length) {//长度为0
        return YES;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [txt stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {//符串中除了空格和换行以外没有任何字符
        return YES;
    }
    return NO;
}

+ (CGSize)calculateTextSizeWithText:(NSString *)text
                               font:(UIFont *)font {
    // 计算字符串的宽度
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize textSize = [text sizeWithAttributes:attributes];
    CGFloat textWidth = textSize.width;

    // 计算字符串的高度
    CGFloat maxHeight = CGFLOAT_MAX; // 设置一个足够大的高度，以便计算整个字符串的高度
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(textWidth, maxHeight)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    CGFloat textHeight = CGRectGetHeight(textRect);
    
    return CGSizeMake(textWidth, textHeight);
}

//获取字符串的size
+ (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width content:(NSString *)content {
    
    NSDictionary *attrs = @{NSFontAttributeName : (font ?: [UIFont fontOfSize:14.0f])};
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    //NSString *testHeight = @"为帮助我们更快处理，请提供问题类型和出现位置等详细信息哦~略略略";
    
    //CGSize RectSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size;
    
    return [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//获取字符串的宽度
+(CGFloat) widthForStr:(NSString *)value
               font:(UIFont *)font
                 height:(float)height {
    CGFloat width=[value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil].size.width;
    
    return width+6;
}

//获得字符串的高度
+(CGSize) heightForStr:(NSString *)value
                font:(UIFont *)font
                width:(float)width {
    ///https://www.jianshu.com/p/5b24e1505432
    return [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName:(font ?: [UIFont fontOfSize:14.0f])}
                               context:nil].size;
}

+ (NSRange)rangeWithValue:(NSString *)value
                   subValue:(NSString *)subValue {
    if(!value || !subValue){
        return NSMakeRange(0, 0);
    }
    // 起始位置
    NSUInteger location = [value rangeOfString:subValue].location;
    // 子字符串的长度
    NSUInteger length = subValue.length;

    NSRange range = NSMakeRange(location, length);
    
    return range;
}

+ (NSString *)handelValue:(NSString *)value {
    return [self handelValue:value defltValue:@"--"];
}

+(NSString *)handelValue:(NSString *)value
              defltValue:(NSString *_Nullable)defltValue {
    if([self isEmptyWithTxt:value]){
        if(!defltValue){
            return @"";
        }
        return defltValue;
    }
    return value;
}

+ (NSString *)transformWithHot:(NSInteger)hot {
    if(hot < 10000){
        return [NSString stringWithFormat:@"%ld", hot];
    }else if (10000 <= hot && hot <= 999999) {
        NSInteger result = hot / 10000;
        NSString *resultStr = [NSString stringWithFormat:@"%ldw+", result];
        
        return resultStr;
    }else {
        return @"99w+";
    }
    
    return @"";
}

+ (NSString *)transformScore:(NSNumber*)score{
    NSInteger scoreValue =  [score integerValue];
    if(scoreValue > 10000000){
        scoreValue = scoreValue  / 10000;
        return [NSString stringWithFormat:@"%ldw", scoreValue];
    }
    return [score stringValue];
}

+ (NSString *)base64EncodeWithTxt:(NSString *)txt {
    
    NSData *data = [txt dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)base64DecodeWithTxt:(NSString *)txt {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:txt options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


///UILabel间距:https://www.jianshu.com/p/badee2350860
///添加图片富文本:https://blog.51cto.com/u_15060467/4269661, https://www.jianshu.com/p/f5c7c29b3f58
+ (NSMutableAttributedString *)richTxtWithTxt:(NSString *)txt
                                      picName:(NSString *)picName {
//    UILabel *_descLab = [[UILabel alloc] init];
//    _descLab.textAlignment = NSTextAlignmentCenter;
//    _descLab.numberOfLines = 2;
    
    //初始化-创建带有图片的富文本-有空格间隙
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"  "];
    //图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:picName];
    attachment.bounds = CGRectMake(0, -3, 54, 17);
    NSAttributedString *imageAttachment = [NSAttributedString attributedStringWithAttachment:attachment];
    //图片
    [attributedString appendAttributedString:imageAttachment];
    
    //文字
    NSString *text = @"订购 云加速专业版会员 (15元/月)\n视频 直播 游戏 学习 应用";
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange textRange = NSMakeRange(0, text.length);
    
    
    //段落样式
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paraStyle.lineSpacing = 10.0;
    //首行文本缩进
    paraStyle.firstLineHeadIndent = 20.0;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [textString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:textRange];
    //文字颜色
    [textString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:textRange];
    //字体
    [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:24 ] range:textRange];
    //将图片放在最后一位
    [textString appendAttributedString:attributedString];
//    _descLab.attributedText = textString;
//
//    return _descLab;
    return textString;
}

+ (NSMutableAttributedString *)hg_imageTextWithImage:(UIImage *)image
                                           imageWH:(CGFloat)imageWH
                                             title:(NSString *)title
                                          fontSize:(CGFloat)fontSize
                                        titleColor:(UIColor *)titleColor
                                           spacing:(CGFloat)spacing {
    
    // 文本字典
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};
    
    // 图片文本
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 换行文本
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    // 按钮文字
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    // 合并文字
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}


+ (NSString *)descriptionWithArray:(NSArray<id> *)array {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

+ (NSString *)descriptionWithDic:(NSDictionary *)dic {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
