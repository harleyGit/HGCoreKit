//
//  HGBaseController.h
//  Demo
//
//  Created by GangHuang on 2023/7/20.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

typedef NS_ENUM(NSInteger,StatusBarStyle) {
    StatusBarStyleLight = 0,
    StatusBarStyleDark = 1,
};

typedef NS_ENUM(NSInteger, NavBarType) {
    NavBarTypeNone = -1,    //没有导航栏
    NavBarTypeSystem = 0,   //系统导航栏
    NavBarTypeCustom = 1,   //自定义导航栏
};

typedef void(^CompleteCallBack) (BOOL isSuccess, id _Nullable data);


NS_ASSUME_NONNULL_BEGIN

@class CustomNavigateBar;
@class LayoutViewVM;
@class BaseViewModel;
@class HGBConlerModel;

@interface HGBaseController : UIViewController<BaseVMDelegate>

//@property(nonatomic, strong, readonly, getter=cnavBar)CustomNavigateBar *customNavBar;
/// 处理工具对象
@property(nonatomic, strong)NSObject *handleObj;
/// 处理业务类
@property(nonatomic, strong)LayoutViewVM* viewModel;
/// 列表
@property(nonatomic, strong, readonly, nullable)UICollectionView* listView;

- (instancetype)initWithParter:(id)parter ;

/// 在Navigation之前布局设置
- (void)layoutBeforeNavionBar;

/// NavigationBar后布局
/// - Parameter frame: 内容大小
- (void)layoutContentViewWithFrame:(CGRect)frame;

/// 导航栏样式
/// - Parameter navBarType: 0 系统样式, 1 自定义样式
- (NSInteger) getNavBarType;

/// 设置状态栏颜色
- (StatusBarStyle) setupStatusBarStyle;

- (void)setupBackgroundColor:(UIColor *)color;

/// ViewModel的初始化和配置的地方
/// 返回值 nil 使用默认View,返回viewModel则是自定义view
- (id _Nullable)configViewModel;


/// 配置参数
/// - Parameters:
///   - parameter: 参数
///   - callBlock: 回调
- (void)setupRouteParameter:(id _Nullable)parameter
                   callBack:(void (^)(id _Nullable argument))callBlock;


/// 开始请求数据
- (void) startRequestData;

/// 列表下拉刷新数据
/// - Parameters:
///   - successBlock: 成功回调
///   - failBlock: 失败回调
- (void) requestOfRefreshSuccessBlock:(CompleteCallBack)successBlock
                            failBlock:(CompleteCallBack)failBlock;
/// 列表上拉加载数据
/// - Parameters:
///   - successBlock: 成功回调
///   - failBlock: 失败回调
- (void) requestOfLoadMoreSuccessBlock:(CompleteCallBack)successBlock
                             failBlock:(CompleteCallBack)failBlock;

- (void) refreshListData;

- (BOOL) forbidRefreshData;

- (BOOL) forbidLoadMoreData;

- (void) lv_sectionHeaderActionType:(NSInteger)actionType
                           data:(id _Nullable)data;
- (void) lv_sectionFooterActionType:(NSInteger)actionType
                           data:(id _Nullable)data;

@end

NS_ASSUME_NONNULL_END
