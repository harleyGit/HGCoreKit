//
//  ShowTxtView.h
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/15.
//  展开+收起 文本View

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ShowTxtView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                      showTxt:(NSString *_Nullable)txt
    actionUnfoldOrPackupBlock:(void (^)(float contentH))actionBlock;

@end

NS_ASSUME_NONNULL_END
