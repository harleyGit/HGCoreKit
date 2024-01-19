//
//  LoadView.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//

#import "LoadView.h"

@implementation LoadView

@end


@implementation TableRefreshHeaderView

//箭头图片UIImageView
-(UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 60, 0, 15, 30)];
        _arrowView.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowView;
}

//下拉刷新文字
-(UILabel *)refreshText {
    if (!_refreshText) {
        _refreshText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 15, 0, 75, 30)];
        _refreshText.font = [UIFont fontWithName:@"Arial" size:14];
        _refreshText.textColor = [UIColor blackColor];
        _refreshText.text = @"下拉刷新";
    }
    return _refreshText;
}

//刷新旋转视图
- (UIActivityIndicatorView *)loadingIndicatorView {
    if (!_loadingIndicatorView) {
        _loadingIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 65, 2, 25, 25)];
        [_loadingIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleMedium];
        _loadingIndicatorView.backgroundColor = [UIColor clearColor];
        _loadingIndicatorView.center = CGPointMake(SCREEN_WIDTH / 2.0 - 52, 14);
    }
    return _loadingIndicatorView;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.arrowView];
        [self addSubview:self.refreshText];
        [self addSubview:self.loadingIndicatorView];
        self.loadingIndicatorView.hidden = YES;
    }
    return self;
    
}


//设置三种刷新模式
- (void)setRefreshMode:(int)mode {
    switch (mode) {
        case 1:{//下拉过程中
            self.arrowView.hidden = NO;
            self.loadingIndicatorView.hidden = YES;
            [self.loadingIndicatorView stopAnimating];
            [UIView animateWithDuration:0.3 animations:^(void){
                self->_arrowView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            }];
            self.refreshText.text = @"下拉刷新";
        }
            break;
        case 2:{//提示松开刷新
            self.arrowView.hidden = NO;
            self.loadingIndicatorView.hidden = YES;
            [self.loadingIndicatorView stopAnimating];
            [UIView animateWithDuration:0.3 animations:^(void){
                self->_arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            self.refreshText.text = @"松开刷新";
        }
            break;
        case 3:{//松开后刷新
            self.arrowView.hidden = YES;
            self.loadingIndicatorView.hidden = NO;
            [self.loadingIndicatorView startAnimating];
            self.refreshText.text = @"正在刷新";
        }
            break;
            
        default:
            break;
    }
}


@end






@implementation TableRefreshFooterView

- (UIActivityIndicatorView *)loadingIndcatorView {
    if (!_loadingIndcatorView) {
        _loadingIndcatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 65, 2, 25, 25)];
        [_loadingIndcatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleMedium];
        _loadingIndcatorView.backgroundColor = [UIColor clearColor];
        _loadingIndcatorView.center = CGPointMake(SCREEN_WIDTH / 2.0 - 52, 14);
    }
    return _loadingIndcatorView;
}

- (UILabel *)loadingText {
    if (!_loadingText) {
        _loadingText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 15, 0, 75, 30)];
        _loadingText.font = [UIFont fontWithName:@"Arial" size:14];
        _loadingText.textColor = [UIColor blackColor];
        _loadingText.text = @"加载中";
    }
    return _loadingText;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loadingIndcatorView];
        [self addSubview:self.loadingText];
    }
    return self;
}



- (void)setLoadingMode:(int)mode {
    switch (mode) {
        case 1:{
            _loadingText.text = @"加载中";
            [self.loadingIndcatorView startAnimating];
            self.loadingIndcatorView.hidden = NO;
        }
            break;
        case 2:{
            _loadingText.text = @"加载完毕";
            [self.loadingIndcatorView stopAnimating];
            self.loadingIndcatorView.hidden = YES;
            _loadingText.hidden = YES;//这个要隐藏,否则没有更多数据还是会显示
        }
            break;
        default:
            break;
    }
}

@end

