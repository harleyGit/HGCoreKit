//
//  BaseCollectionHeaderView.m
//  MLC
//
//  Created by Gang Huang on 11/20/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "BaseReusableView.h"

#import "BaseReusableViewM.h"


@interface BaseReusableView ()



@end

@implementation BaseReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addHeaderOrFooterSubViews];
    }
    return self;
}

- (void)bindHeadOrFooterModelData:(BaseReusableViewM *)modelData {}

- (void)addHeaderOrFooterSubViews {}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:GlobalFontName0 size:24.0f];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
@end
