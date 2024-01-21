//
//  TextShowModel.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/15.
//

#import "TextShowModel.h"
#import "TxtUtil.h"

@interface TextShowModel ()

@end

@implementation TextShowModel

- (void)setContent:(NSString *)content {
    _content = content;
    if ([TxtUtil isEmptyWithTxt:_content]) {
        self.titleActualH = 0;
        self.titleMaxH = 0;
    } else {
        NSUInteger numCount = 5; //这是cell收起状态下期望展示的最大行数
        NSString *str = @"这是一行用来计算高度的文本"; //这行文本也可以为一个字，但不能太长
        CGFloat W = SCREEN_WIDTH - 30; //这里是文本展示的宽度
        
        //针对普通文本计算size大小:https://blog.csdn.net/jijiji000111/article/details/52823482
        //CGSize)size  表示计算文本的最大宽高、就是限制的最大高度、宽度，一般情况下我们设置最大的宽度、高度不限制CGSizeMake(getScreenWidth(), CGFLOAT_MAX)，注意：限制的宽度不同，计算的高度结果也不同
        //NSStringDrawingUsesLineFragmentOrigin: 绘制文本时使用 line fragement origin 的计算类型
        //attributes 表示富文本的属性: http://caiiiac.github.io/blog/2015/08/10/nsattributedstring-wen-ben-shu-xing-xiang-jie/
        //  NSFontAttributeName: 字体，value是UIFont对象
        //context: ontext上下文。包括一些信息，例如如何调整字间距以及缩放。该参数一般可为 nil
        self.titleActualH = [content boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        self.titleMaxH = [str boundingRectWithSize:CGSizeMake(W, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height*numCount;
    }
}

@end
