//
//  HGBaseController.m
//  Demo
//
//  Created by GangHuang on 2023/7/20.
//

#import "HGBaseController.h"
#import "CustomNavigateBar.h"
#import "LayoutView.h"
#import "Toast.h"

#import "UIScreen+Ext.h"
#import "UIImage+Ext.h"
#import "UIView+Ext.h"

#import "LayoutViewVM.h"
//#import "NetManager.h"
#import "LayoutViewDelegate.h"
//#import "NetIntercept.h"

#import "HGBConlerModel.h"


@interface HGBaseController ()<CNavBarDelegate, LayoutViewDelegate,
UIGestureRecognizerDelegate>{
}
//NetHandleProtocol,
@property(nonatomic, strong)LayoutView *layoutView;
@property(nonatomic, strong, readwrite)CustomNavigateBar *customNavBar;

@end

@implementation HGBaseController

- (CustomNavigateBar *)customNavBar {
    if(!_customNavBar){
        _customNavBar = [CustomNavigateBar navigationBar];
        _customNavBar.delegate = self;
    }
    
    return _customNavBar;
}

- (nullable UICollectionView *)listView {
    if(!self.viewModel){
        return nil;
    }
    
    return self.layoutView.listView;
}

///loadView方法在UIViewController对象的view属性被访问到且为空的时候调用
/// 替换ViewController自带View
-(void)loadView {
    [super loadView];
    
    if (![self configViewModel]) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen naviHeight], [UIScreen getScreenWidth], [UIScreen getScreenHeight])];
        return;
    }
    
    self.viewModel.delegate = self;
    self.view = [self configLayoutViewWithViewModel:self.viewModel];
    self.view.userInteractionEnabled = YES;
    
}

- (LayoutView *)configLayoutViewWithViewModel:(LayoutViewVM *)viewModel {
    if (_layoutView) {
        return _layoutView;
    }
    CGRect frame = CGRectMake(0, 0, [UIScreen getScreenWidth], [UIScreen getScreenHeight]);
    _layoutView = [[LayoutView alloc] initWithFrame:frame
                                       layoutConfig:nil
                                          viewModel:viewModel];
    _layoutView.delegate = self;
    
    return _layoutView;
}

- (instancetype)init {
    self = [super init];
    if(self){
        [self configViewModel];
    }
    return self;
}

///建议:最好在这个地方弄一个数据模型,然后其他类来继承它,对其进行扩展
///或者一个类也行
///在我的信息遇到一个这方面的优化
- (instancetype)initWithParter:(id)parter {
    self = [super init];
    if(self){
        [self configViewModel];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIView.defaultMainColor;

    [self layoutBeforeNavionBar];
    [self setupNavigationBar];
    [self layoutContentViewWithFrame:CGRectMake(0, [UIScreen naviHeight], SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self setupRefreshAndLoadMore];
    [self startRequestData];
}

- (void)layoutBeforeNavionBar {}

- (void)layoutContentViewWithFrame:(CGRect)frame{}

- (void)setupBackgroundColor:(UIColor *)color {
    if(!self.viewModel){
        self.view.backgroundColor = color;
    }else {
        self.view.backgroundColor = color;
        self.listView.backgroundColor = color;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    //添加代码 适配iOS11 scrollView下移问题
    if (@available(iOS 11.0, *)) {
        [self.layoutView setupContentInsetAdjust];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void) refreshListData{
    if(!self.layoutView){
        return;
    }
    
    [self.layoutView reloaData];
}

- (void)startRequestData{
    //[[NetManager sharedManager] setIntereDelegate:self];
}

- (void) setupRefreshAndLoadMore {
    if(!self.viewModel && ![self.view isKindOfClass:[LayoutView class]]){
        return;
    }
    
    LayoutView *layoutView = self.layoutView;
    [layoutView setupRefreshAndLoadMoreConfig];
}


- (void) requestOfRefreshSuccessBlock:(CompleteCallBack)successBlock
                          failBlock:(CompleteCallBack)failBlock {}

- (void) requestOfLoadMoreSuccessBlock:(CompleteCallBack)successBlock
                             failBlock:(CompleteCallBack)failBlock {}

- (BOOL) forbidRefreshData {
    return YES;
}

- (BOOL) forbidLoadMoreData {
    return YES;
}

- (void) lv_sectionHeaderActionType:(NSInteger)actionType
                               data:(id _Nullable)data{}
- (void) lv_sectionFooterActionType:(NSInteger)actionType
                               data:(id _Nullable)data{}

- (NSInteger) getNavBarType {
    return NavBarTypeCustom;
}

- (StatusBarStyle) setupStatusBarStyle {
    return StatusBarStyleLight;
}

- (void)setupRouteParameter:(id _Nullable)parameter
                   callBack:(void (^)(id _Nullable argument))callBlock{}

- (id _Nullable)configViewModel {
    return nil;
}



#pragma mark -- 状态栏颜色
// 仅当前页面状态栏文字颜色 - 系统方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self setupStatusBarStyle] == StatusBarStyleLight) {
        // 白色
        return UIStatusBarStyleLightContent;
    }else{
        // 黑色
        if (@available(iOS 13.0, *)) {
            return UIStatusBarStyleDarkContent;
        } else {
            return UIStatusBarStyleDefault; //黑色, 默认值
        }
    }
}

#pragma mark -- 自定义导航栏&系统导航栏
- (void)setupNavigationBar {
    
    switch ([self getNavBarType]) {
        case NavBarTypeCustom:
            [self useCustomNav];
            break;
        case NavBarTypeSystem:
            [self configSystemNavBar];
            break;
        default:
            break;
    }
}

- (void)useCustomNav {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view addSubview:self.customNavBar];
    [self.customNavBar layoutNavionContentView];
    self.customNavBar.layer.zPosition = MAXFLOAT;
    
    __weak typeof(self) weakSelf = self;
    [self.customNavBar navionLeftAcionBlock:^(NSInteger actionType, id  _Nullable data) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        switch (actionType) {
            case NavigateTypeBack:
                [strongSelf navBackAction:nil];
                break;
                
            default:
                break;
        }
        
    } rightActionBlock:^(NSInteger actionType, id  _Nullable data) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        switch (actionType) {
            case NavigateTypeBack:
                [strongSelf navBackAction:nil];
                break;
                
            default:
                break;
        }
    }];
    
    [self.customNavBar updateShowNavBarStatus];
}


- (void)configSystemNavBar {
    UIImage* backImage = [[UIImage imageNamed:@"navi_back_icon"] transformToSize:CGSizeMake(11, 22)];
    CGRect backframe = CGRectMake(0,0,44,34);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setImage:backImage forState:UIControlStateNormal];
    //[backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //backButton.titleLabel.font=[UIFont customFitDesignFontSize:13];
    [backButton addTarget:self action:@selector(navBackAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -12.0, 0, 10);
    
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:PIC_PATH(WM.zjConfig.naBackIcon)] transformToSize:CGSizeMake(10, 20)] style:UIBarButtonItemStyleDone target:self action:@selector(navBackAction:)];
    
    [self hideOrShowNavBar];
    
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" menu:nil];
    //self.navigationController.navigationBar.backIndicatorImage = [[UIImage imageNamed:PIC_PATH(WM.zjConfig.naBackIcon)] transformToSize:CGSizeMake(10, 20)];
    //self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:PIC_PATH(WM.zjConfig.naBackIcon)] transformToSize:CGSizeMake(10, 20)];
    
    
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //设置导航栏背景
    //CGSize size = CGSizeMake(self.view.frame.size.width, 90);
    //UIView *navBarV = [[UIImageView alloc] initWithImage: [[UIImage alloc] initWithSize:size color:[UIColor clearColor]]];
    //[self.view addSubview:navBarV];
}


- (void)navBackAction:(UIButton  * _Nullable)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self hideOrShowNavBar];
}

- (void)hideOrShowNavBar {
    if([self getNavBarType] == NavBarTypeCustom){
        [self.customNavBar updateShowNavBarStatus];
        return;
    }
    
    [self hideOrShowSystemNavBar];
}


- (void)hideOrShowSystemNavBar {
    if(self.navigationController.viewControllers.count > 1){//显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }else{//隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

#pragma mark -- LayoutViewDelegate

- (void)refreshOfSuccessBlock:(CompleteCallBack)successBlock
                    failBlock:(CompleteCallBack)failBlock {
    [self requestOfRefreshSuccessBlock:successBlock
                             failBlock:failBlock];
}

- (void)loadMoreOfSuccessBlock:(CompleteCallBack)successBlock
                     failBlock:(CompleteCallBack)failBlock {
    [self requestOfLoadMoreSuccessBlock:successBlock
                              failBlock:failBlock];
}

- (BOOL)forbidRefresh {
    return [self forbidRefreshData];
}

- (BOOL)forbidLoadMore {
    return [self forbidLoadMoreData];
}

- (void)cellActionType:(NSInteger)actionType data:(id)data {}

- (void)sectionHeaderActionType:(NSInteger)actionType
                           data:(id _Nullable)data {
    [self lv_sectionHeaderActionType:actionType data:data];
}

- (void)sectionFooterActionType:(NSInteger)actionType
                           data:(id _Nullable)data {
    [self lv_sectionFooterActionType:actionType data:data];
}

#pragma mark -- CNavBarDelegate
- (BOOL)hideNavionView {
    if(self.navigationController.viewControllers.count > 1){//显示导航栏
        return NO;
    }else{//隐藏导航栏
        return  YES;
    }
}

- (NSString * _Nullable)navTitle {
    return nil;
}

#pragma mark - NetHandleProtocol
- (void)netInterHandelWithStatusCode:(NSInteger)statusCode {}


#pragma mark -- BaseVMDelegate
- (void)showToastMsg:(NSString *)msg {
    [Toast show:msg superView:self.view];
}


@end
