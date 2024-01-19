//
//  ListCell.m
//  HGCoreSDK
//
//  Created by GangHuang on 2023/7/19.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)updateContentModel:(NSDictionary *)model{
    self.textLabel.text = model[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
