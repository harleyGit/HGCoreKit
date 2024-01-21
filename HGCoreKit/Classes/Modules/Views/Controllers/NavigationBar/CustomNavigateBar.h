//
//  CustNavgateBar.h
//  KIWComSDK
//
//  Created by Gang Huang on 30/8/2023.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger , NavigateActionType) {
    NavigateTypeBack = 0,
    NavigateTypeClose
};

typedef void (^NavionActionBlock)(NSInteger index, id _Nullable data);


NS_ASSUME_NONNULL_BEGIN

@protocol CNavBarDelegate <NSObject>


@required

@optional
- (BOOL)hideNavionView;

- (NSString * _Nullable)navTitle;
- (nullable UIView*)navionCustomCenter;

- (nullable UIButton*)navionCustomLeftBack;
- (NSArray<NSString *> * _Nullable)navionLeftTitles ;
- (NSArray<NSString *> * _Nullable)navionRightTitles;
- (nullable NSArray<UIButton *> *)navionLeftBtns;
- (nullable NSArray<UIButton *> *)navionRightBtns;

- (nullable NSArray<NSString *> *)navionLeftPics;
- (nullable NSArray<NSString *> *)navionRightPics;

- (nullable UIView *)navionCustomContentView;


@end




@interface CustomNavigateBar : UIView

@property(nonatomic, weak)id<CNavBarDelegate> delegate;

@property (nonatomic ,assign) BOOL showCloseBtn;

+ (instancetype) navigationBar;

- (void)layoutNavionContentView;

- (void)updateShowNavBarStatus;

- (void)navionLeftAcionBlock:(NavionActionBlock)leftActionBlock rightActionBlock:(NavionActionBlock)rightActionBlock;
@end

NS_ASSUME_NONNULL_END
