//
//  BaseController.h
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseController : UIViewController

/** 记录将需要在退出VC取消的请求。
 *  在记录的时候，清理已经请求完成的task
 *  如果请求需要有取消功能，那么在failure的block中，需要添加对取消的失败不做任务处理的实现。
 */
- (void)addSessionDataTask:(NSURLSessionDataTask *)task;

/** 取消所有的请求 */
- (void)cancelAllSessionDataTask;

@end

NS_ASSUME_NONNULL_END
