//
//  LoadView.h
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadView : UIView

@end



/// 下拉刷新View
@interface TableRefreshHeaderView : LoadView

@property(nonatomic, strong)UIImageView *arrowView;

@property(nonatomic, strong)UILabel *refreshText;

@property(nonatomic, strong)UIActivityIndicatorView *loadingIndicatorView;

-(instancetype)initWithFrame:(CGRect)frame;

- (void)setRefreshMode:(int)mode;

@end



/// 上拉加载View
@interface TableRefreshFooterView : LoadView

@property(nonatomic, strong) UIActivityIndicatorView *loadingIndcatorView;

@property(nonatomic, strong) UILabel *loadingText;

- (void)setLoadingMode:(int)mode;

@end


NS_ASSUME_NONNULL_END
