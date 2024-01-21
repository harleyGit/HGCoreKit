//
//  BaseViewModel.h
//  KIWComSDK
//
//  Created by GangHuang on 9/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol BaseVMDelegate <NSObject>

@optional

- (void)showToastMsg:(NSString  * _Nullable )msg;

@end

@interface BaseViewModel : NSObject

@property(nonatomic, weak)id<BaseVMDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
