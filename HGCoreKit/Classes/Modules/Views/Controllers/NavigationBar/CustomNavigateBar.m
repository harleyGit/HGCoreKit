//
//  CustNavgateBar.m
//  KIWComSDK
//
//  Created by Gang Huang on 30/8/2023.
//


#import "CustomNavigateBar.h"
#import "UIColor+Ext.h"
#import "TxtUtil.h"

NSInteger const BTN_LEFT_TAG = 400;
NSInteger const BTN_RIGHT_TAG = 420;


@interface CustomNavigateBar (){
    CGFloat _sy;
    CGFloat _nH;
}

@property (nonatomic ,strong) UIButton * backBtn;
@property(nonatomic, strong)UILabel *titleLab;

@property (nonatomic ,copy) NavionActionBlock leftActionBlock;
@property (nonatomic ,copy) NavionActionBlock rightActionBlock;



@end

@implementation CustomNavigateBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _sy = [[UIScreen mainScreen] statusBarHeight];
        _nH = self.hg_height - _sy;
        _showCloseBtn = NO;
        self.backgroundColor = [UIColor colorFromHexCode:@"#000205"];
    }
    return self;  
}

+ (instancetype) navigationBar {
    CustomNavigateBar *bar = [[CustomNavigateBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, UINAV_HEIGHT)];
    //bar.backgroundColor = [UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1];
    
    return bar;
}

- (void) updateShowNavBarStatus {
    BOOL isHidden = NO;
    if ([self.delegate respondsToSelector:@selector(hideNavionView)]) {
        isHidden = [self.delegate hideNavionView];
    }
    self.hidden = isHidden;
}

- (void)navionLeftAcionBlock:(NavionActionBlock)leftActionBlock rightActionBlock:(NavionActionBlock)rightActionBlock {
    self.leftActionBlock = leftActionBlock;
    self.rightActionBlock =  rightActionBlock;
}

- (void)leftActionSender:(UIButton *)sender {
    NSInteger actionType = sender.tag = BTN_LEFT_TAG;

}
- (void)rightActionSender:(UIButton *)sender {
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if([self isUseCNavionContentView]){
        return;
    }
    
    if(![self isUseCBackBtn]){
        self.backBtn.frame = CGRectMake(0, _sy, 68, 44);
    }
    
    
    CGFloat titW = [TxtUtil widthForStr:self.titleLab.text font:self.titleLab.font height:44];
    CGFloat titY = [UIScreen statusBarHeight] + ([UIScreen navigationBarHeight] - 44)/2;
    self.titleLab.frame = CGRectMake(([UIScreen getScreenWidth] - titW)/2, titY, titW, 44);
}

- (void)layoutNavionContentView {
    
    if([self isUseCNavionContentView]){
        [self layoutCNavionContentView];
        return;
    }
    
    [self layoutLeftBack];
    [self addLeftTitleBtn];
    
    BOOL isShowTitle = YES;
    NSString *title = @"";
    if ([self.delegate respondsToSelector:@selector(navTitle)]) {
        title = [self.delegate navTitle];
        isShowTitle = ![TxtUtil isEmptyWithTxt:title];
    }
    if(!isShowTitle){
        return;
    }
    self.titleLab.text= title;
    [self addSubview:_titleLab];
    
    [self layoutNavionRight];
}

- (void)layoutCNavionContentView {
    UIView *contentV = [self.delegate navionCustomContentView];
    if(contentV){
        [contentV setHg_y:[UIScreen statusBarHeight]];
        [self addSubview:contentV];
        return;
    }
}

- (void)layoutLeftBack {
    
    if([self isUseCBackBtn]){
        UIButton *clbtn = [self.delegate navionCustomLeftBack];
        [self addSubview:clbtn];
        return;
    }
    [self addSubview:self.backBtn];
}

- (void)layoutNavionRight {
    CGFloat rM = 12;
    CGFloat rW = 40;
    
    if([self isUseCRightBtns]){
        NSArray<UIButton *> *rBtns = [self.delegate navionRightBtns];
        for (int i = 0; i< rBtns.count; ++i) {
            UIButton *btn = rBtns[i];
            btn.frame = CGRectMake(self.hg_width - i*rW-(rW+rM), _sy, rW, _nH);
            [self addSubview:btn];
        }
    }
}

- (void)addLeftTitleBtn {
    CGFloat x = self.backBtn.hg_right;
    CGFloat btw = 44.0;
    if(self.delegate && [self.delegate respondsToSelector:@selector(navionLeftTitles)]){
        NSArray *titles = [self.delegate navionLeftTitles];
        UIFont *font= [UIFont fontWithName:@"HarmonyOS_Sans_SC" size:15.0];
        for (int i = 0; i< titles.count; ++i) {
            NSString *title = titles[i];
            CGSize titleSize = [TxtUtil calculateTextSizeWithText:title font:font];
            UIButton *btn = [self createBtnWithTitle:title font:font];
            btn.frame = CGRectMake(x+btw*i, [UIScreen statusBarHeight], btw, btw);
            btn.tag = BTN_LEFT_TAG + i;
            
            [btn addTarget:self action:@selector(leftActionSender:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (UIButton *)createBtnWithTitle:(NSString *)title font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return btn;
}

- (void)setShowCloseBtn:(BOOL)showCloseBtn{
    _showCloseBtn = showCloseBtn;
}

- (void)backAction{
    BlockSafeRun(self.leftActionBlock,NavigateTypeBack, nil);
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(SCREEN_WIDTH -24, 44.0f);
}


/// 是否使用自定义导航栏View
- (BOOL)isUseCNavionContentView {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(navionCustomContentView)]){
        return YES;
    }
    return NO;
}
/// 是否使用自定义返回按钮
- (BOOL)isUseCBackBtn {
    if(self.delegate && [self.delegate respondsToSelector:@selector(navionCustomLeftBack)]){
        return YES;
    }
    return NO;
}
- (BOOL)isUseCRightBtns {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(navionRightBtns)]){
        return YES;
    }
    return NO;
}


- (UIButton *)backBtn {
    if(!_backBtn){
        _backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_backBtn setImage:[UIImage imageNamed:@"navi_back_icon"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(2, -6, 2, 6);
    }
    return _backBtn;
}

- (UILabel *)titleLab {
    if(!_titleLab){
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:@"HarmonyOS_Sans_SC_Bold" size:20.0];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}

@end
