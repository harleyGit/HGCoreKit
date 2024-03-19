//
//  BaseJSONModel.h
//  NetTest
//
//  Created by Harley Huang on 19/3/2024.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeNone = 0,
    kRequestTypeGet = 1,
    kRequestTypePut = 2,
    kRequestTypePost = 3,
    kRequestTypeUpload = 4,
    kRequestTypeDelete = 5,
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseJSONModel : NSObject

@end


@interface WebServiceRequestModel : BaseJSONModel

/** 重试的剩余次数 */
@property (nonatomic, assign) NSInteger times;

/** 请求类型 */
@property (nonatomic, assign) RequestType requestType;

/** 请求url */
@property (nonatomic, strong) NSString *urlStr;

/** 请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/** upload时的数组 */
@property (nonatomic, strong) NSArray *formDataArray;

/** 是否在请求 */
@property (nonatomic, assign) BOOL isRequesting;



@end

NS_ASSUME_NONNULL_END
