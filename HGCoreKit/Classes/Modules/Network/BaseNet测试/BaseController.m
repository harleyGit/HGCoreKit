//
//  BaseController.m
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import "BaseController.h"

@interface BaseController ()

@property (nonatomic, strong) NSPointerArray *sessionDataTaskMArr;


@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}


/** 将需要在退出VC取消的请求，记录。
 *  在记录的时候，清理已经请求完成的task
 */
- (void)addSessionDataTask:(NSURLSessionDataTask *)task
{
    if (nil == task) {
        return;
    }

    [self.sessionDataTaskMArr compact];

    [self.sessionDataTaskMArr addPointer:(__bridge void * _Nullable)(task)];
}

/** 取消所有的请求 */
- (void)cancelAllSessionDataTask
{
    if (0 >= [self.sessionDataTaskMArr count]) {
        return;
    }

    [self.sessionDataTaskMArr compact];

    for (NSURLSessionDataTask *dataTask in self.sessionDataTaskMArr) {
        /*
         * NSURLSessionTaskStateRunning：表示任务正在执行中，正在发送请求并等待响应。
         * NSURLSessionTaskStateSuspended：表示任务被暂停了，等待被继续执行。
         * NSURLSessionTaskStateCompleted：表示任务已完成，可能是成功地获取了数据或者遇到了错误。
         */
        if (NSURLSessionTaskStateRunning == dataTask.state
            || NSURLSessionTaskStateSuspended == dataTask.state) {
            [dataTask cancel];
        }
    }
   
    //compact 方法是 NSPointerArray 的一个方法，用于压缩数组以移除 nil 值，它的作用是将数组中的 nil 值移动到数组的末尾并且调整数组的长度，这样可以使得数组中连续存储的对象不会因为中间有 nil 值而间断，从而提高了数组的效率和内存利用率。
    [self.sessionDataTaskMArr compact];
}

- (NSPointerArray *)sessionDataTaskMArr
{
    if (nil == _sessionDataTaskMArr) {
        _sessionDataTaskMArr = [NSPointerArray weakObjectsPointerArray];
    }

    return _sessionDataTaskMArr;
}





#pragma mark - Override Methods

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0)
{
    [self cancelAllSessionDataTask];

    [super dismissViewControllerAnimated:flag completion:completion];
}



@end
