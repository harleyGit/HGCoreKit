//
//  ButtnLayoutUtil.m
//  HGCoreSDK
//
//  Created by Harley Huang on 22/7/2023.
//
/// UIButton根据内容自动布局: https://juejin.cn/post/6844903845374459917
/// 数值与滑块: https://www.jianshu.com/p/8dac60bf640f

#import "ButtnLayoutUtil.h"
#import "UIImage+Util.h"

@interface ButtnLayoutUtil ()

@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGRect titleRect;

@end

@implementation ButtnLayoutUtil


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    } else {
        return [super titleRectForContentRect:contentRect];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.imageRect)&&!CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    } else {
        return [super imageRectForContentRect:contentRect];
    }
}

- (void)setupWithImgRect:(CGRect)imgRect
               titleRect:(CGRect)titleRect
                 imgName:(NSString *_Nullable)imgName
                   title:(NSString *_Nullable)title {
        self.imageRect = imgRect;
        self.titleRect = titleRect;
        [self layoutIfNeeded];//!< 立即得出btn自适应后的frame
        [self setImage:[[UIImage imageNamed:imgName] transformToSize:imgRect.size] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
}

- (void)setupWithImgName:(NSString *_Nullable)imgName
                   title:(NSString *_Nullable)title
                 imgSize:(CGSize)imgSize
         imgPositionType:(BtnImgPostionType)type {
    
    [self setImage:[[UIImage imageNamed:imgName] transformToSize:imgSize] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self updateWithImgPostionType:type];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    BOOL hasSetTitleRect = !(CGRectIsEmpty(self.titleRect) || CGRectEqualToRect(self.titleRect, CGRectZero));
    BOOL hasSetImageRect = !(CGRectIsEmpty(self.imageRect) || CGRectEqualToRect(self.imageRect, CGRectZero));
    
    if (hasSetImageRect || hasSetTitleRect) {
        CGRect rect = self.frame;
        CGRect curentRect =  CGRectUnion(hasSetImageRect ? self.imageRect : CGRectZero, hasSetTitleRect  ? self.titleRect : CGRectZero);
        rect.size.width = curentRect.size.width + curentRect.origin.x * 2;
        rect.size.height = curentRect.size.height + curentRect.origin.y * 2;
        self.frame = rect;
    }
    
}



- (void)updateWithImgPostionType:(BtnImgPostionType)type {
    switch (type) {
        case BtnImgPostionTypeRight:{//左字右图
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - (self.imageView.bounds.size.width+10), .0, (self.imageView.bounds.size.width+10));
            self.imageEdgeInsets = UIEdgeInsetsMake(.0, self.titleLabel.bounds.size.width +10, 0, - self.titleLabel.bounds.size.width);
        }
            break;
        case  BtnImgPostionTypeTop:{//图上文下
            self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.frame.size.height + 10.0, - self.imageView.bounds.size.width, .0, .0);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0, self.titleLabel.bounds.size.width / 2, self.titleLabel.frame.size.height + 10.0, - self.titleLabel.bounds.size.width / 2);
        }
            break;
            
        default:{//文字距离图片10
            self.titleEdgeInsets = UIEdgeInsetsMake(.0, 20, 0, -20);
        }
            break;
    }
}

@end
