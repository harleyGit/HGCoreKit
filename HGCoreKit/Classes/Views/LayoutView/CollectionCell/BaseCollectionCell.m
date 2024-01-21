//
//  BaseCollectionCell.m
//  MLC
//
//  Created by Gang Huang on 11/19/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "BaseCollectionCell.h"
#import "BaseCCellProtocol.h"

@interface BaseCollectionCell ()<BaseCellDelegate>


@end

@implementation BaseCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self addCellSubViews];
    }
    
    return self;
}

///在这里可以加一个判断,还是不要加了 影响性能
//- (void)bindCellModdelData:(id<BaseCCellProtocol>)modelData{}
- (void)bindCellModdelData:(id)modelData{}
- (void)selectCellWithIndexPath:(NSIndexPath *)indexPath model:(id)model{}

- (void)addCellSubViews {}



#pragma mark -- Set & Get
-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont fontWithName:GlobalFontName3 size:18.0f];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}


@end
