//
//  HGContant.m
//  HGCoreKit
//
//  Created by Harley Huang on 20/1/2024.
//

#import "HGContant.h"

const CGFloat GlobalMarginTop = 16.0f;
const CGFloat GlobalMarginLeft = 16.0f;
const CGFloat GlobalMarginBottom = 16.0f;
const CGFloat GlobalMarginRight = 16.0f;

NSString* const GlobalFontName0 = @"PingFangTC-Semibold";
NSString* const GlobalFontName1 = @"PingFangTC-Medium";
NSString* const GlobalFontName2 = @"PingFangTC-Regular";
NSString* const GlobalFontName3 = @"PingFangTC-Light";
NSString* const GlobalFontName4 = @"PingFangTC-Thin";
NSString* const GlobalFontName5 = @"PingFangTC-Ultralight";

NSString * const TEST_NOTIFY_NAME = @"com.alamofire.networking.task.resume";

@implementation HGContant


+(CGFloat)leftMargin {
    return 16.0f;
}

+(CGFloat)RightMargin {
    return 16.0f;
}


+ (NSString *)wxBaseURL {
    return @"https://api.weixin.qq.com/sns";
}
// 注册微信时的AppID
+ (NSString *)wxKmetaAppID {
    return @"wx384859c5d8de64fa";
}
//注册时得到的AppSecret
+ (NSString *)wxKmetaAppSecret {
    return @"";
}
+ (NSString *)WX_ACCEESS_TOKEN_KEY {
    return @"access_token";
}
+ (NSString *)WX_OPEN_ID_KEY {
    return @"openid";
}
+ (NSString *)WX_REFRESH_TOKEN_KEY {
    return @"refresh_token";
}
+ (NSString *)WX_UNION_ID_KEY{
    return @"unionid";
}

+ (NSString *) bundleDocumentName:(NSString *)name {
    return [NSString stringWithFormat:@"KIWComSDK.framework/HGSourceBundle.bundle/%@", name];
}

+ (NSString *_Nullable)transformPictureSuffixWithData:(NSData *)picData {
    if(!picData){
        return @"";
    }
    
    SDImageFormat format = [NSData sd_imageFormatForImageData:picData];
    switch (format) {
        case SDImageFormatUndefined:
            return @"";
            break;
        case SDImageFormatJPEG:
            return @"jpeg";
            break;
        case SDImageFormatPNG:
            return @"png";
            break;
        case SDImageFormatGIF:
            return @"gif";
            break;
        case SDImageFormatTIFF:
            return @"tiff";
            break;
        case SDImageFormatWebP:
            return @"webp";
            break;
        case SDImageFormatHEIC:
            return @"heic";
            break;
        case SDImageFormatHEIF:
            return @"heif";
            break;
        case SDImageFormatPDF:
            return @"pdf";
            break;
        case SDImageFormatSVG:
            return @"svg";
            break;
        default:
            break;
    }
    
    return @"";
}


@end
