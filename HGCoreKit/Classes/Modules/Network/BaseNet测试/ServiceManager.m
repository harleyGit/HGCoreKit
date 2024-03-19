//
//  ServiceManager.m
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
// 资料: https://juejin.cn/post/6844903736968478727

/** 下述功能只是大概,后面可以参考这种思路进行修正弥补
 * 1. 请求失败后,重新请求测试
 * 2. controller销毁后,页面还有其他请求,进行取消,避免浪费流量;
 */

#import "ServiceManager.h"
#import "BaseJSONModel.h"

#import "AFNetworking.h"

@interface ServiceManager ()


@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray<WebServiceRequestModel *> *requestMArr;

@end

static NSTimeInterval kTimeInterval = 3.0;


@implementation ServiceManager



+ (instancetype)shareInstace
{
    static ServiceManager *webServiceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webServiceManager = [[ServiceManager alloc] init];
        
        webServiceManager.maxRetryTimes = 3;
        
        [webServiceManager initialNetwork];
    });
    
    return webServiceManager;
}

- (void)requestWithType:(RequestType)type url:(NSString *)url params:(NSDictionary *)param formDataArray:(NSArray *)formDataArray
{
    WebServiceRequestModel *model = [[WebServiceRequestModel alloc] init];
    model.times = self.maxRetryTimes;
    model.requestType = type;
    model.urlStr = url;
    model.params = param;
    model.formDataArray = formDataArray;
    model.isRequesting = NO;
    
    [self.requestMArr addObject:model];
    
    if (![self.timer isValid]) {
        [self.timer fire];
    }
}



#pragma mark - Initial Methods

- (void)initialNetwork
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

- (void)networkChanged:(NSNotification *)notification
{
    NSNumber *status = [notification.userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    if (AFNetworkReachabilityStatusNotReachable == [status integerValue]) {
        if (self.timer.isValid) {
            //这一行代码设置了 NSTimer 对象的 fireDate 属性，将其设置为一个遥远的未来的时间，即 [NSDate distantFuture]。
            //fireDate 属性表示 NSTimer 下一次触发的时间。将其设置为遥远的未来意味着暂时关闭了这个 NSTimer，因为在设置的时间之前，NSTimer 不会触发。
            //这种技术通常用于暂停或者延迟 NSTimer 的触发时间。
            self.timer.fireDate = [NSDate distantFuture];
        }
    } else {
        if (![self.timer isValid]) {
            [self.timer fire];
        } else {
            self.timer.fireDate = [NSDate date];
        }
    }
}


#pragma mark - Target Methods

- (void)requestNetwork
{
    if (0 >= [self.requestMArr count]
        || ![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [self.timer invalidate];
        self.timer = nil;
        
        return;
    }
    
    for (WebServiceRequestModel *model in self.requestMArr) {
        [self requestWithModel:model];
    }
}

- (void)requestWithModel:(WebServiceRequestModel *)model
{
    if (model.isRequesting) {
        return;
    }
    
    /*
    __weak typeof(self) weakSelf = self;
    switch (model.requestType) {
        case kRequestTypeGet:
        {
            [HXQWebService getRequest:model.urlStr
                           parameters:model.params
                             progress:nil
                              success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
                
                if (status == kNoError
                    || 0 >= model.times) {
                    [weakSelf.requestMArr removeObject:model];
                }
                
            } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
            }];
        }
            break;
            
        case kRequestTypePut:
        {
            [HXQWebService putRequest:model.urlStr
                           parameters:model.params
                              success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
                
                if (status == kNoError
                    || 0 >= model.times) {
                    [weakSelf.requestMArr removeObject:model];
                }
            } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
            }];
        }
            break;
            
        case kRequestTypePost:
        {
            [HXQWebService postRequest:model.urlStr
                            parameters:model.params
                              progress:nil
                               success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
                
                if (status == kNoError
                    || 0 >= model.times) {
                    [weakSelf.requestMArr removeObject:model];
                }
            } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
            }];
        }
            break;
            
        case kRequestTypeUpload:
        {
            [HXQWebService uploadRequest:model.urlStr
                              parameters:model.params
                           formDataArray:model.formDataArray
                                progress:nil
                                 success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
                
                if (status == kNoError
                    || 0 >= model.times) {
                    [weakSelf.requestMArr removeObject:model];
                }
            } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
            }];
        }
            break;
            
        case kRequestTypeDelete:
        {
            [HXQWebService deleteRequest:model.urlStr
                              parameters:model.params
                                 success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
                
                if (status == kNoError
                    || 0 >= model.times) {
                    [weakSelf.requestMArr removeObject:model];
                }
            } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                model.isRequesting = NO;
            }];
        }
            break;
            
        default:
            break;
    }
    */
    model.isRequesting = YES;
    model.times = (0 < model.times--) ?:0;
}



#pragma mark - Getter Methods

- (NSTimer *)timer
{
    if (nil == _timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(requestNetwork) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

- (NSMutableArray *)requestMArr
{
    if (nil == _requestMArr) {
        _requestMArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _requestMArr;
}


@end
