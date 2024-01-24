//
//  HGAppleStorePay.h
//  MLC
//
//  Created by Harley Huang on 30/3/2023.
//  Copyright © 2023 HuangGang'sMac. All rights reserved.
//  https://www.jianshu.com/p/2f98b7937b6f

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HGAppleStorePay;

@protocol HGAppStorePayDelegate <NSObject>;

@optional

/**
 wct20180418 内购支付成功回调

 @param appStorePay 当前类
 @param dicValue 返回值
 @param error 错误信息
 */
- (void)appStorePay:(HGAppleStorePay *)appStorePay responseAppStorePaySuccess:(NSDictionary *)dicValue error:(NSError*)error;


/**
 wct20180423 内购支付结果回调提示
 
 @param appStorePay 当前类
 @param dicValue 返回值
 @param error 错误信息
 */
- (void)appStorePay:(HGAppleStorePay *)appStorePay responseAppStorePayStatusshow:(NSDictionary *)dicValue error:(NSError*)error;

@end


@interface HGAppleStorePay : NSObject

@property (nonatomic, weak)id<HGAppStorePayDelegate> delegate;/**<wct20180418 delegate*/


/**
  wct20180411 点击购买

 @param goodsID 商品id
 */
-(void)starBuyToAppStore:(NSString *)goodsID;


@end

NS_ASSUME_NONNULL_END
