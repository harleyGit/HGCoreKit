//
//  UIView+Ext.m
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import "UIView+Ext.h"
#import "UIApplication+Ext.h"

@implementation UIView (Ext)

static UIColor *_defaultMainColor = nil;
@dynamic defaultMainColor;

+ (UIViewController *)controllerOfView:(UIView *)view {
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    }
    // 如果没有找到则返回nil
    return nil;
}

+(UIColor *)defaultMainColor {
    if(!_defaultMainColor){
        _defaultMainColor = [UIColor colorWithRed:240/255.0f green:239/255.0f blue:246/255.0f alpha:1.0f];
    }
    return _defaultMainColor;
}

- (void)setHg_x:(CGFloat)hg_x{
    CGRect frame = self.frame;
    frame.origin.x = hg_x;
    self.frame = frame;
}

- (CGFloat)hg_x {
    return  CGRectGetMinX(self.frame);
}

- (float)hg_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)hg_y {
    //max: view的宽度作为x, mid view宽度的1/2作为x, min view现在的宽度
    return CGRectGetMinY(self.frame);
}

- (void)setHg_y:(CGFloat)hg_y  {
    CGRect frame = self.frame;
    frame.origin.y = hg_y;
    self.frame = frame;
}

- (CGFloat)hg_centerY {
    return  CGRectGetMidY(self.frame);
}

- (CGFloat)hg_centerX {
    return CGRectGetMidX(self.frame);
}

-(CGFloat)hg_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)hg_width{
    return CGRectGetWidth(self.frame);
}
- (void)setHg_width:(CGFloat)hg_width {
    CGRect frame = self.frame;
    frame.size.width = hg_width;
    self.frame = frame;
}

-(CGFloat)hg_height{
    return CGRectGetHeight(self.frame);
}

- (void)setHg_height:(CGFloat)hg_height {
    CGRect frame = self.frame;
    frame.size.height = hg_height;
    self.frame = frame;
}

- (void)drawCircle {
    // 创建一个圆形掩码
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:maskLayer.bounds];
    maskLayer.path = maskPath.CGPath;
    // 将掩码设置为UIImageView的layer的mask
    self.layer.mask = maskLayer;
}

- (void)setupCornerRadius:(CGFloat)radius {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
    if([self isKindOfClass:[UIButton class]]){
        [self.layer addSublayer:maskLayer];
        return;
    }
    self.layer.mask = maskLayer;
}


+ (UIView *)topFullScreenView {
    return [UIApplication topViewController].view;
}

- (void)startUpDownTranslationAnimation:(CGFloat)move duration:(CGFloat)duration {
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y+move)];
    translation.duration = duration;
    translation.repeatCount = HUGE_VALF;
    translation.autoreverses = YES;
    translation.removedOnCompletion = NO;
    [self.layer addAnimation:translation forKey:@"translation"];
}


@end
