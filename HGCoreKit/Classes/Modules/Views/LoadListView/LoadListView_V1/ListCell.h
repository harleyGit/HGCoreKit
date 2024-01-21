//
//  ListCell.h
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCell : UITableViewCell

- (void)updateContentModel:(NSDictionary *)model;

@end

NS_ASSUME_NONNULL_END
