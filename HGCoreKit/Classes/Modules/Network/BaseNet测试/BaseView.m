//
//  BaseView.m
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import "BaseView.h"

#import "BaseController.h"


@interface BaseView ()

@property (nonatomic, weak) UIViewController *rootViewController;

@end

@implementation BaseView



#pragma mark - Cancel Task

/** 将需要在退出VC取消的请求，记录。
 *  在记录的时候，清理已经请求完成的task
 */
- (void)addSessionDataTask:(NSURLSessionDataTask *)task
{
    UIViewController *currentVC = self.rootViewController;

    if ([currentVC isKindOfClass:[BaseController class]]) {
        [(BaseController *)currentVC addSessionDataTask:task];
    }
}


#pragma mark - Private

- (UIViewController *)rootViewController
{
    if (nil == _rootViewController) {
        for (UIView *next = [self superview]; next; next = next.superview) {
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                _rootViewController = (UIViewController *)nextResponder;

                return _rootViewController;
            }
        }
    }

    return _rootViewController;
}




@end
