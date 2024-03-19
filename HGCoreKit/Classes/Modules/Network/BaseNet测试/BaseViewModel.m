//
//  BaseViewModel.m
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import "BaseViewModel.h"


NSInteger const kRequestTimeInterval = 3;

@interface BaseViewModel ()

@property (nonatomic, strong) NSMapTable *requestTimeMDic;
@property (nonatomic, strong) NSMapTable *cancelTaskMDic;

@end

@implementation BaseViewModel




- (BOOL)ignoreRequestWithUrl:(NSString *)url params:(NSDictionary *)params
{
    return [self ignoreRequestWithUrl:url params:params timeInterval:kRequestTimeInterval];
}

- (BOOL)ignoreRequestWithUrl:(NSString *)url params:(NSDictionary *)params timeInterval:(NSTimeInterval)timeInterval
{
    NSString *requestStr = [NSString stringWithFormat:@"%@%@", url, @"[params uq_URLQueryString]"];
    NSString *requestMD5 = @"[NSString md5:requestStr]";
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *lastTimeNum = [self.requestTimeMDic objectForKey:requestMD5];

    __weak typeof(self)  weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 超过忽略时间后，将值清空
        [weakSelf.requestTimeMDic removeObjectForKey:requestMD5];
    });


    if (timeInterval < (nowTime - [lastTimeNum doubleValue])) {
        if (0.01 > [lastTimeNum doubleValue]) {
            [self.requestTimeMDic setObject:@(nowTime) forKey:requestMD5];
        }

        return NO;
    } else {
        return YES;
    }
}

- (void)cancelLastTaskSessionWithUrl:(NSString *)url currentTaskSession:(NSURLSessionTask *)task
{
    NSURLSessionTask *lastSessionTask = [self.cancelTaskMDic objectForKey:url];

    if (nil == lastSessionTask) {
        [self.cancelTaskMDic setObject:task forKey:url];

        return;
    }

    [lastSessionTask cancel];
}

- (void)clearTaskSessionWithUrl:(NSString *)url
{
    [self.cancelTaskMDic removeObjectForKey:url];
}




#pragma mark - Remove Unused Things


#pragma mark - Private Methods


#pragma mark - Getter Methods

- (NSMapTable *)requestTimeMDic
{
    if (nil == _requestTimeMDic) {
        _requestTimeMDic = [NSMapTable weakToWeakObjectsMapTable];
    }

    return _requestTimeMDic;
}

- (NSMapTable *)cancelTaskMDic
{
    if (nil == _cancelTaskMDic) {
        _cancelTaskMDic = [NSMapTable weakToWeakObjectsMapTable];
    }

    return _cancelTaskMDic;
}



@end
