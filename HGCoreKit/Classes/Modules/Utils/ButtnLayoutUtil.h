//
//  ButtnLayoutUtil.h
//  HGCoreSDK
//
//  Created by Harley Huang on 22/7/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, BtnImgPostionType) {
    BtnImgPostionTypeDefault = 0,   //默认
    BtnImgPostionTypeRight = 1,     //右图
    BtnImgPostionTypeTop = 2,       //上图
};

@interface ButtnLayoutUtil : UIButton

- (void)setupWithImgRect:(CGRect)imgRect
               titleRect:(CGRect)titleRect
                 imgName:(NSString *_Nullable)imgName
                   title:(NSString *_Nullable)title;

- (void)setupWithImgName:(NSString *_Nullable)imgName
                   title:(NSString *_Nullable)title
                 imgSize:(CGSize)imgSize
         imgPositionType:(BtnImgPostionType)type;

@end

NS_ASSUME_NONNULL_END
