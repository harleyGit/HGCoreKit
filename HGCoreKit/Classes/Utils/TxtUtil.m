//
//  TxtUtil.m
//  HGCoreKit
//
//  Created by Harley Huang on 19/1/2024.
//

#import "TxtUtil.h"

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

@end
