//
//  ServiceManager.h
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import <Foundation/Foundation.h>

#import "BaseJSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceManager : NSObject

/** 重试的次数，默认为3次 */
@property (nonatomic, assign) NSUInteger maxRetryTimes;

/** 创建单例，可以在界面消失后，继续执行 */
+ (instancetype)shareInstace;

/** 将执行的请求保存，进行多次重试，指导成功 */
- (void)requestWithType:(RequestType)type url:(NSString *)url params:(NSDictionary *)param formDataArray:(NSArray *)formDataArray;



@end

NS_ASSUME_NONNULL_END
