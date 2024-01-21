//
//  ShowTxtView.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/15.
//

#import "ShowTxtView.h"
#import "TextShowModel.h"

#import "TxtUtil.h"

typedef void(^ ActionUnfoldOrPackupBlock) (float txtH);

@interface ShowTxtView ()<UITextViewDelegate>

@property(nonatomic, strong)UITextView *contentTextView;
@property(nonatomic, strong)TextShowModel *txtM;
@property(nonatomic, copy)ActionUnfoldOrPackupBlock actionBlock;

@end

@implementation ShowTxtView

-(UITextView *)contentTextView {
    if(!_contentTextView){
        _contentTextView = [[UITextView alloc]initWithFrame:self.frame];
        _contentTextView.delegate = self;
        [_contentTextView setEditable:NO];
    }
    return _contentTextView;
}

-(TextShowModel *)txtM {
    if(!_txtM){
        _txtM = [[TextShowModel alloc] init];
    }
    return _txtM;
}

- (instancetype)initWithFrame:(CGRect)frame
                      showTxt:(NSString *_Nullable)txt
    actionUnfoldOrPackupBlock:(void (^)(float contentH))actionBlock{
    self = [super initWithFrame: frame];
    if(self){
        [self addSubview:self.contentTextView];
        self.txtM.content = txt;
        [self setupCellData:self.txtM];
        self.actionBlock = actionBlock;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.txtM.titleMaxH);
    }
    return self;
}


- (void)setupCellData:(TextShowModel *)model {
    
    NSString *suffixStr = @""; //添加的后缀按钮文本（收起或展开）
    NSString *contentStr = model.content;
    CGFloat H = model.titleActualH; //文本的高度，默认为实际高度
    
    if (model.titleActualH > model.titleMaxH) {
        //文本实际高度>最大高度，需要添加后缀
        if (model.isOpen) {
            //文本已经展开，此时后缀为“收起”按钮
            suffixStr = @"收起";
            contentStr = [NSString stringWithFormat:@"%@ %@", contentStr, suffixStr];
            H = model.titleActualH;
        } else {
            //文本已经收起，此时后缀为“展开/全文”按钮
            //需要对文本进行截取，将“...展开”添加到我们限制的展示文字的末尾
            NSUInteger numCount = 5; //这是cell收起状态下期望展示的最大行数
            CGFloat W = SCREEN_WIDTH-30; //这里是文本展示的宽度
            NSString *tempStr = [self stringByTruncatingString:contentStr suffixStr:@"...展开" font:[UIFont systemFontOfSize:14] forLength:W*numCount];
            contentStr = tempStr;
            suffixStr = @"展开";
            H = model.titleMaxH;
        }
    }

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.contentTextView.linkTextAttributes = @{};
    
    //给富文本的后缀添加点击事件
    if(![TxtUtil isEmptyWithTxt:suffixStr]){
        NSRange range3 = [contentStr rangeOfString:suffixStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:range3];//[UIColor colorWithHexString:@"#000000"]
        NSString *valueString3 = [[NSString stringWithFormat:@"didOpenClose://%@", suffixStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [attStr addAttribute:NSLinkAttributeName value:valueString3 range:range3];
    }
    
    //UITextView实现多链接文本:https://www.jianshu.com/p/94c945411257
    self.contentTextView.attributedText = attStr;
}

/// 将文本按长度度截取并加上指定后缀
/// @param str 文本
/// @param suffixStr 指定后缀
/// @param font 文本字体
/// @param length 文本长度
- (NSString*)stringByTruncatingString:(NSString *)str
                            suffixStr:(NSString *)suffixStr
                                 font:(UIFont *)font
                            forLength:(CGFloat)length {
    if (!str) return nil;
    if (str  && [str isKindOfClass:[NSString class]]) {
        for (int i=(int)[str length] - (int)[suffixStr length]; i< [str length];i = i - (int)[suffixStr length]){
            NSString *tempStr = [str substringToIndex:i];//截取字符串到第几位:https://blog.csdn.net/qq_39848087/article/details/80798161
            CGSize size = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
            if(size.width < length){
                tempStr = [NSString stringWithFormat:@"%@%@",tempStr,suffixStr];
                CGSize size1 = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
                if(size1.width < length){
                    str = tempStr;
                    break;
                }
            }
        }
    }
    return str;
}


#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    self.txtM.isOpen = !(self.txtM.isOpen);
    CGPoint VOrigin = self.frame.origin;
    CGSize VSize = self.frame.size;
    [self setupCellData:self.txtM];


    if ([[URL scheme] isEqualToString:@"didOpenClose"]) {
        //点击了“展开”或”收起“，通过代理或者block回调，让持有tableView的控制器去刷新单行Cell
        if (self.actionBlock) {
            if(self.txtM.isOpen){
                self.frame = CGRectMake(VOrigin.x, VOrigin.y, VSize.width, self.txtM.titleActualH);
                self.actionBlock(self.txtM.titleActualH);
            }else {
                self.frame = CGRectMake(VOrigin.x, VOrigin.y, VSize.width, self.txtM.titleMaxH);
                self.actionBlock(self.txtM.titleMaxH);
            }
        }
        self.contentTextView.frame = self.frame;
        return NO;
    }
    return YES;
}

- (void)layoutSubviews {
    
}



@end
