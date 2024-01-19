//
//  LoadListController.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
/// UIViewController中的UITableView下拉刷新和上拉加载功能的实现:https://www.cnblogs.com/lzmfywz/p/5765137.html
/// UITableViewController实现系统上拉加载下拉刷新:https://blog.csdn.net/zhonggaorong/article/details/51213674 (备用:https://www.jianshu.com/p/52085235cd21)
/// contentSize、contentOffSet、contentInset关系:https://www.jianshu.com/p/9091e5f34df5

/**
 * contentOffset和contentInset: https://juejin.cn/post/6865636938347446279, https://blog.csdn.net/hherima/article/details/44811767, https://blog.csdn.net/hherima/article/details/44811767
 
 * contentSize 是scrollview可以滚动的区域，比如frame = (0 ,0 ,320 ,480) contentSize = (320 ,960)，代表你的scrollview可以上下滚动，滚动区域为frame大小的两倍
 
 * contentOffset 是scrollview当前显示区域顶点相对于frame顶点的偏移量（向屏幕内拉，偏移量是负值。向屏幕外推，偏移量是正数），比如上个例子，从初始状态向下拉50像素，contentoffset就是(0 ,-50)，从初始状态向上推tableview100像素，contentOffset就是(0 ,100)。
 
 * contentInset 是scrollview的contentview的顶点相对于scrollview的位置，例如你的contentInset = (0 ,100)，那么你的contentview就是从scrollview的(0 ,100)开始显示. 与之联系的contentOffset的值是:(0 ,-100)
 */

#import "LoadListController.h"
#import "LoadView.h"
#import "ListCell.h"



@interface LoadListController ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL isMoreData;
    BOOL isLoading;//是否正在加载
    BOOL isRefreshing;//是否正在刷新
    int drageMode;//1为下拉刷新，2为上拉加载
}

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)TableRefreshHeaderView *refreshHeaderView;
@property(nonatomic, strong)TableRefreshFooterView *loadingFooterView;
@property (strong ,nonatomic)NSMutableArray<NSDictionary *> *modelArray;
@property(nonatomic, assign)NSInteger pageNum;


@end

@implementation LoadListController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TableRefreshHeaderView *)refreshHeaderView
{
    if (!_refreshHeaderView) {
        _refreshHeaderView = [[TableRefreshHeaderView alloc]initWithFrame:CGRectMake(0, -30, SCREEN_WIDTH, 30)];
    }
    return _refreshHeaderView;
}

- (TableRefreshFooterView *)loadingFooterView
{
    if (!_loadingFooterView) {
        _loadingFooterView = [[TableRefreshFooterView alloc]initWithFrame:CGRectMake(0, self.tableView.contentSize.height, SCREEN_WIDTH, 30)];
    }
    return _loadingFooterView;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.hidden = YES;
    //    [self configNavigationBar];
    
    
    isMoreData = YES;
    _pageNum = 0;
    isLoading = NO;
    isRefreshing = NO;
    drageMode = -1;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshHeaderView];
    [self.tableView addSubview:self.loadingFooterView];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}


- (void) loadRequestAccAppDataWithType:(NSInteger)type isRefresh:(BOOL)isRefresh pageNum:(NSInteger)pageNum {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(2);//处理耗时操作
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(isRefresh){//若是刷新
                [self.modelArray removeAllObjects];
            }
            
            if(self.modelArray.count > 20 ){//加载更多没有数据了
                if(isRefresh){
                    [self endRefresh];
                }else {
                    self->isMoreData = NO;
                    [self endLoadingWithNoMoreData:YES];
                }
                return;
            }
            
           
            NSArray<NSDictionary *> *models =  @[@{ @"title":@"😀",}, @{ @"title":@"🥹🤪",}, @{ @"title":@"😇",}, @{ @"title":@"🥰",}, @{ @"title":@"🍏",},];
            [self.modelArray addObjectsFromArray:models];
            
            if(isRefresh){
                [self endRefresh];
            }else {
                [self endLoadingWithNoMoreData:NO];
            }
        });
    }) ;
}



//开始刷新
- (void)beginRefresh{
    self.pageNum = 1;
    self->isRefreshing = YES;
    [self loadRequestAccAppDataWithType:1 isRefresh:YES pageNum:self.pageNum];
}

//停止刷新
- (void)endRefresh {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    [self.tableView reloadData];
    [self.refreshHeaderView setRefreshMode:1];
    isRefreshing = NO;
    self->isMoreData = YES;
    
}

//开始加载
- (void)beginLoading {
    self.pageNum ++;
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    self->isLoading = YES;
    //            rowCount += 10;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    [self loadRequestAccAppDataWithType:2 isRefresh:NO pageNum:self.pageNum];
    
    //            sleep(2);//处理耗时操作
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self.tableView reloadData];
    //            [self endLoading];//处理完之后更新界面
    //        });
    //    }) ;
}

//停止加载
- (void)endLoadingWithNoMoreData:(BOOL)isNoMore {
    [self.tableView reloadData];
    //[self endLoading];//处理完之后更新界面
    
    if(isNoMore){
        [self.loadingFooterView setLoadingMode:2];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
        [self.loadingFooterView setLoadingMode:1];
    }
    isLoading = NO;
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ListCellIdentifier";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *infoModel = [self.modelArray objectAtIndex:indexPath.row];
    [cell updateContentModel:infoModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
}





-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果列表控件加载完毕且当前为下拉加载，则将下拉加载视图移到列表可视范围之外
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row && drageMode == 2){
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

//监听UITableview的顶部和头部下拉事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //当tableview滚动到底部的时候，
    //手机屏幕高度+contentoffset.y=contentSize.height。那么当再向上拖拽tableview到橙色区域的时候，这个时候contentoffset.y继续增大，导致手机屏幕高度+contentoffset.y > contentSize.height。
    //这个时候我们就说明用户在tableview到达了最底部，还在向上拖拽，想看到更多的内容。我们就可以调用加载更多的方法来加载更多数据了
    
    if ([keyPath isEqualToString:@"contentOffset"] && !isLoading && !isRefreshing) {
        self.loadingFooterView.frame = CGRectMake(0, self.tableView.contentSize.height, SCREEN_WIDTH, 30);
        if (self.tableView.isDragging) {
            if (self.tableView.contentOffset.y > -45) {
                [self.refreshHeaderView setRefreshMode:1];
            }else if (self.tableView.contentOffset.y < -45){
                [self.refreshHeaderView setRefreshMode:2];
            }
        }else{
            NSLog(@"--->> self.tableView.contentOffset.y: %f", self.tableView.contentOffset.y);
            NSLog(@"\nself.tableView.contentSize.height:%f", self.tableView.contentSize.height);
            NSLog(@"\nself.tableView.frame.size.height:%f", self.tableView.frame.size.height);
            if (self.tableView.contentOffset.y < -45) {
                drageMode = 1;
                self.tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
                [self.refreshHeaderView setRefreshMode:3];
                [self beginRefresh];
            } else if (self.tableView.contentOffset.y  > self.tableView.contentSize.height - self.tableView.frame.size.height + 45) {
                drageMode = 2;
                if (self->isMoreData) {
                    [self.loadingFooterView setLoadingMode:1];
                    [self beginLoading];
                } else {
                    [self.loadingFooterView setLoadingMode:2];
                    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
                }
            }
        }
    }
}

@end
