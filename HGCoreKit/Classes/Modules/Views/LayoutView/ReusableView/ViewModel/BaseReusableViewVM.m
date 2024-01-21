//
//  BaseReusableViewVM.m
//  MLC
//
//  Created by Gang Huang on 11/26/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "BaseReusableViewVM.h"

#import "BaseReusableView.h"


@interface BaseReusableViewVM ()
/// header标识符
@property(nonatomic, copy)NSString *headerIdentifier;
/// footer标识符
@property(nonatomic, copy)NSString *footerIdentifier;
@end

@implementation BaseReusableViewVM

- (Class)headerClassName {
    return BaseReusableView.class;
}

- (NSString *)headerIdentifier {
    return [NSString stringWithFormat:@"%@", self.headerClassName];
}

- (Class)footerClassName {
    return BaseReusableView.class;

}

- (NSString *)footerIdentifier {
    return [NSString stringWithFormat:@"%@", self.footerClassName];
}


- (CGSize)headerSize {
    return CGSizeMake(SCREEN_WIDTH, 0.01f);
}

- (CGSize)footerSize {
    return CGSizeMake(SCREEN_WIDTH, 0.01f);
}

- (void)bindModelWithHeaderOrFooterView:(BaseReusableView *)headerOrFooterView {
    [headerOrFooterView bindHeadOrFooterModelData:self.model];
}


- (void) regiseterHeaderViewClassInCollectionView:(UICollectionView *)collectionView {
    
    Class headerClass = NSClassFromString(self.headerIdentifier);
    [collectionView registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass)];
}

- (void) regiseterFooterViewClassInCollectionView:(UICollectionView *)collectionView {
    
    Class footerClass = NSClassFromString(self.footerIdentifier);
    [collectionView registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass)];
}

@end
