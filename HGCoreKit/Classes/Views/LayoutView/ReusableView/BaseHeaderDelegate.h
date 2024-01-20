//
//  BaseHeaderDelegate.h
//  MLC
//
//  Created by Gang Huang on 11/20/22.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseHeaderDelegate <NSObject>

@optional
- (void) headerActionType:(NSInteger)actionType data:(id _Nullable)data;
- (void) footerActionType:(NSInteger)actionType data:(id _Nullable)data;

@end

NS_ASSUME_NONNULL_END
