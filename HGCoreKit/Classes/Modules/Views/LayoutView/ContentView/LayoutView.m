//
//  LayoutView.m
//  MLC
//
//  Created by Gang Huang on 11/13/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import "LayoutView.h"
#import "BaseCollectionCell.h"
#import "BaseReusableView.h"
#import "MJRefresh.h"
#import "UIView+Ext.h"
#import "UIScreen+Ext.h"

#import "BaseHeaderDelegate.h"

@interface LayoutView ()<BaseHeaderDelegate, BaseCellDelegate>

@property(nonatomic, strong, readwrite) UICollectionView *collectionView;
@property(nonatomic, strong)LayoutViewVM *viewModel;

@end



@implementation LayoutView

- (instancetype)initWithFrame:(CGRect)frame
                 layoutConfig:(nullable UICollectionViewFlowLayout *)viewLayout {
    LayoutViewVM *vm = [self setupLayoutViewModel];
    if(!vm){
        return [[LayoutView alloc] initWithFrame:frame];
    }
    self = [self initWithFrame:frame
                  layoutConfig:nil
                     viewModel:vm];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                 layoutConfig:(nullable UICollectionViewFlowLayout *)viewLayout
                    viewModel:(LayoutViewVM *)viewModel{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = UIView.defaultMainColor;
        _viewModel = viewModel;
        
        [self layoutCollectionViewWithLayoutConfig:viewLayout];
        [self registerSectionSubViewClass];
        [self addSubViews];
    }
    
    return  self;
}

- (UICollectionView *)layoutCollectionViewWithLayoutConfig:(UICollectionViewFlowLayout *)viewLayout {
    if (!_collectionView) {
        if (!viewLayout) {
            viewLayout = [UICollectionViewFlowLayout new];
            //设置滑动的方向:竖直 UICollectionViewScrollDirectionVertical, 水平 UICollectionViewScrollDirectionHorizontal
            viewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            //设置item之间的最小间距(竖直滑动的时候，表示的横向间距，水平滑动的时候，表示的是纵向间距)
            viewLayout.minimumInteritemSpacing = 35;
            //设置item之间的最小间距(竖直滑动的时候，表示的纵向间距，水平滑动的时候，表示的是横向间距)
            viewLayout.minimumLineSpacing = 10;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:viewLayout];
        ///显示分页效果
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = UIView.defaultMainColor;
        ///不显示竖直滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        ///不显示水平滚动条
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 设置滚动视图的contentInsetAdjustmentBehavior为Never
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {}
        
    }
    return _collectionView;
}

- (void) addSubViews {
    CGFloat y = [UIScreen naviHeight];
    self.collectionView.frame = CGRectMake(0, y, self.hg_width, self.hg_height -y);
    [self addSubview:self.collectionView];
}

- (void) registerSectionSubViewClass {
    if (![self.viewModel respondsToSelector:@selector(registerSectionSubViewClassInCollectionView:)]) {
        return;
    }
    
    [self.viewModel registerSectionSubViewClassInCollectionView:self.collectionView];
}

- (void)setupBgColor:(UIColor *)color {
    self.backgroundColor = color;
    self.collectionView.backgroundColor = color;
}

- (nullable LayoutViewVM *)setupLayoutViewModel {
    return nil;
}


- (void)setupContentInsetAdjust {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}

//https://www.jianshu.com/p/e1a40f46aed7
- (void)setupRefreshAndLoadMoreConfig {
    
    if([self.delegate respondsToSelector:@selector(forbidRefresh)]){
        BOOL isRefresh = [self.delegate forbidRefresh];
        if(!isRefresh){
            //下拉刷新
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshOfLoadData)];
            //自动更改透明度
            self.collectionView.mj_header.automaticallyChangeAlpha = YES;
        }
    }
    
    
    if([self.delegate respondsToSelector:@selector(forbidLoadMore)]){
        BOOL isLoadMore = [self.delegate forbidLoadMore];
        if(!isLoadMore){
            //上拉加载
            self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOfLoadData)];
        }
    }
}

- (void)reloaData {
    [self.collectionView reloadData];
}


- (void) refreshOfLoadData {
    //进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
    if(![self.delegate respondsToSelector:@selector(refreshOfSuccessBlock:failBlock:)]){
        return;
    }
    
    
    __weak __typeof(self) weakSelf = self;
    [self.delegate refreshOfSuccessBlock:^(BOOL isSuccess, NSString * _Nullable msg) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.collectionView.mj_header endRefreshing];
    } failBlock:^(BOOL isFail, NSString * _Nullable msg) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.collectionView.mj_header endRefreshing];
    }];
}

- (void) loadMoreOfLoadData {
    
    if(![self.delegate respondsToSelector:@selector(loadMoreOfSuccessBlock:failBlock:)]){
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [self.delegate loadMoreOfSuccessBlock:^(BOOL isSuccess, id _Nullable resObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        //结束尾部刷新
        [strongSelf.collectionView.mj_footer endRefreshing];
    } failBlock:^(BOOL isFail, id _Nullable failObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        //结束尾部刷新
        [strongSelf.collectionView.mj_footer endRefreshing];
    }];
    
}

#pragma mark -- BaseCellDelegate
- (void)cellActionType:(NSInteger)actionType data:(id _Nullable)data {
    if (![self.delegate respondsToSelector:@selector(cellActionType:data:)]) {
        return;
    }
    
    [self.delegate cellActionType:actionType data:data];
}


#pragma mark -- BaseHeaderDelegate

- (void)headerActionType:(NSInteger)actionType data:(id _Nullable)data {
    if(![self.delegate respondsToSelector:@selector(sectionHeaderActionType:data:)]){
        return;
    }
    
    [self.delegate sectionHeaderActionType:actionType data:data];
}

- (void)footerActionType:(NSInteger)actionType data:(id _Nullable)data {
    if(![self.delegate respondsToSelector:@selector(sectionFooterActionType:data:)]){
        return;
    }
    
    [self.delegate sectionFooterActionType:actionType data:data];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self findTopMostCellInCollectionView:self.collectionView];
}

- (void)findTopMostCellInCollectionView:(UICollectionView *)collectionView {
    if(![self.delegate respondsToSelector:@selector(topCellWithIndexPath:)]){
        return;
    }
    NSArray<UICollectionViewCell *> *visibleCells = [collectionView visibleCells];
    CGFloat topMostY = CGFLOAT_MAX;
    UICollectionViewCell *topMostCell = nil;
    
    for (UICollectionViewCell *cell in visibleCells) {
        CGRect cellFrameInCollectionView = [collectionView convertRect:cell.frame toView:collectionView.superview];
        
        if (cellFrameInCollectionView.origin.y < topMostY) {
            topMostY = cellFrameInCollectionView.origin.y;
            topMostCell = cell;
        }
    }
    
    // 获取顶部 cell 的数据，例如 dataID
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:topMostCell];
    [self.delegate topCellWithIndexPath:indexPath];
    
}


#pragma mark -- UICollectionViewDelegate协议
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didSelectSectionOfCellAtIndexPath:indexPath];
    
    id model = [self.viewModel cellModelWithIndexPath:indexPath];
    BaseCollectionCell *selectCell = (BaseCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [selectCell selectCellWithIndexPath:indexPath model:model];
}


#pragma mark -- UICollectionViewDataSource协议
//section的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(![self.viewModel respondsToSelector:@selector(sectionCount)]) {
        return  0;
    }
    return [self.viewModel sectionCount];
}


/// 返回对应section中cell的数量
/// @param collectionView collectionView
/// @param section 第几个Section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (![self.viewModel respondsToSelector:@selector(numberOfCellsInSection:)]) {
        return 0;
    }
    
    return [self.viewModel numberOfCellsInSection:section];
}

//cell的展示
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.viewModel cellStringnFromClassInSection:indexPath.section];
    if (!identifier) {
        identifier = @"UICollectionViewCell";
        UICollectionViewCell *viewCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        return viewCell;
    }
    
    //注意单元格复用，注意identifier和之前注册时用的相同(@"cell")
    BaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.cellDelegate = self;
    [self.viewModel bindModelWithCell:cell indexPath:indexPath];
    
    return cell;
}


///返回头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    BaseReusableView *resuableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        NSString *headerIdentifier = [self.viewModel headerStringFromClassInSection:indexPath.section];
        if (!headerIdentifier) {
            return nil;
        }
        
        resuableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        resuableView.hfDelegate = self;
        
        [self.viewModel bindModelWithHeaderView:resuableView indexPath:indexPath];
    } else if (kind == UICollectionElementKindSectionFooter) {
        NSString *footerIdentifier = [self.viewModel footerStringnFromClassInSection:indexPath.section];
        if (!footerIdentifier) {
            return nil;
        }
        
        resuableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        resuableView.hfDelegate = self;
        
        [self.viewModel bindModelWithFooterView:resuableView indexPath:indexPath];
    }
    return resuableView;
}

///cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!self.viewModel){
        return CGSizeZero;
    }
    
    CGSize cellSize = [self.viewModel cellSizeWithIndexPath:indexPath];
    if(CGSizeEqualToSize(cellSize, CGSizeZero)) {
        return [self.viewModel sectionCellSizeInSection:indexPath.section];
    }
    return cellSize;
}


///cell的左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (!self.viewModel) {
        return 0.001;
    }
    
    return [self.viewModel cellInteritemSpaceInSection:section];
}

///返回元素之间允许的最小间距
///如果是水平滑动，则代表cell上下的距离
///如果竖直滑动，则代表横向距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (!self.viewModel) {
        return 0.001;
    }
    
    return [self.viewModel cellLineSpaceInSection:section];
}

//每个Section内的cells外部距离（上，左，下，右）距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self.viewModel insetSection:section];
}



#pragma mark -- UICollectionViewDelegateFlowLayout协议
///返回头部视图的CGSize，如果是水平滑动，则宽度有效，如果是竖直滑动，只有高度有效
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (!self.viewModel) {
        return CGSizeMake(SCREEN_WIDTH, 0.001);
    }
    return [self.viewModel headerViewSizeInSection:section];
}

/// footer 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (!self.viewModel) {
        return CGSizeMake(SCREEN_WIDTH, 0.001);
    }
    
    return [self.viewModel footerViewSizeInSection:section];
}


@end
