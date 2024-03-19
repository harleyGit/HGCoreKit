//
//  BaseViewModel.h
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject

#pragma mark - 忽略请求

/** 忽略请求，当请求的url和参数都是一样的时候，在短时间内不发起再次请求， 默认3秒 */
- (BOOL)ignoreRequestWithUrl:(NSString *)url params:(NSDictionary *)params;

/** 忽略请求，当请求的url和参数都是一样的时候，在短时间内不发起再次请求 */
- (BOOL)ignoreRequestWithUrl:(NSString *)url params:(NSDictionary *)params timeInterval:(NSTimeInterval)timeInterval;


#pragma mark - 取消之前的请求

/** 取消之前的同一个url的网络请求
 *  在failure分支中，判断如果是取消操作，那么不做任何处理
 *  在success和failure分支中，都要调用clearTaskSessionWithUrl:方法，进行内存释放
 */
- (void)cancelLastTaskSessionWithUrl:(NSString *)url currentTaskSession:(NSURLSessionTask *)task;

/** 清除url绑定的sessionTask */
- (void)clearTaskSessionWithUrl:(NSString *)url;



@end

NS_ASSUME_NONNULL_END
