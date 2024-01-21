//
//  LayoutViewDelegate.h
//  MLC
//
//  Created by Gang Huang on 11/19/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@class使用: https://juejin.cn/post/6996795324601729031
//@class BaseCollectionCell;
typedef void(^CompleteCallBack) (BOOL isSuccess, id _Nullable data);

@protocol LayoutViewDelegate <NSObject>

@optional

- (void)refreshOfSuccessBlock:(CompleteCallBack)successBlock
                           failBlock:(CompleteCallBack)failBlock;

- (void)loadMoreOfSuccessBlock:(CompleteCallBack)successBlock
                           failBlock:(CompleteCallBack)failBlock;

- (void)cellActionType:(NSInteger)actionType data:(id _Nullable)data;
- (void)sectionHeaderActionType:(NSInteger)actionType data:(id _Nullable)data;
- (void)sectionFooterActionType:(NSInteger)actionType data:(id _Nullable)data;

- (BOOL) forbidRefresh;
- (BOOL) forbidLoadMore;

- (void) topCellWithIndexPath:(NSIndexPath *)indexPath;


@required



@end

NS_ASSUME_NONNULL_END
