//
//  FileManager.h
//  MLC
//
//  Created by Harley Huang on 20/12/2022.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//  文件管理: https://www.cnblogs.com/wyqfighting/p/3155069.html
//  Bundle文件使用: https://www.cnblogs.com/richard-youth/p/7744759.html


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///沙盒文件夹类型
typedef NS_ENUM(NSInteger, SandboxDirectoryType) {
    ///沙盒Documents文件夹,App运行时生成的需要持久化的数据，iTunes备份和恢复的时候会包括此目录
    SandboxDirectoryTypeDocuments = 0,
    ///沙盒Caches文件夹存，iTunes不会备份此目录，此目录下文件不会在应用退出后删除 。
    SandboxDirectoryTypeCaches = 1,
    ///保存APP的所有偏好设置，iOS的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录
    SandboxDirectoryTypePreferences = 2,
    ///保存应用运行时所需的临时数据，这个可以放一些当APP退出后不再需要的文件,iTunes不会同步该目录
    SandboxDirectoryTypeTmp = 3,
    
};

@interface HGFileManager : NSObject


/// bundle路径
+(NSBundle *)sourceBundlePath;

/// 文件信息
/// @param path 路径
+(NSDictionary*)getFileInfo:(NSString*)path;

/// 获取文件路径下文件大小·
/// @param path 文件路径
+(long long)getFileSizeWithFilePath:(NSString*)path;


/// 删除某些后缀的文件
/// @param suffixList 后缀列表
/// @param path 路径
/// @param deep 是否深度
+(void)removeFileSuffixList:(NSArray<NSString*>*)suffixList
                   filePath:(NSString*)path
                       deep:(BOOL)deep;
/// 删除文件夹
/// @param path 文件夹路径
+(BOOL)removeDir:(NSString*)path;

/// 删除文件
/// @param filePath 文件路径
+(BOOL)removeFilePath:(NSString*)filePath;

/// 移动文件
/// @param fromPath 起始文件路径
/// @param toPath 目的路径
/// @param dir 文件夹
+(BOOL)moveFile:(NSString *)fromPath
         toPath:(NSString *)toPath
    toPathIsDir:(BOOL)dir;

/// 获取文件夹下所有文件(深度遍历)
/// @param path 文件路径
+(NSArray*)getAllFileListWithFolderPath:(NSString*)path;

/// 获取文件夹下所有文件列表
/// @param folderPath 文件夹路径
+(NSArray*)getFileListWithFolderPath:(NSString*)folderPath;

/// 读取数据
/// @param filePath 文件路径
+(NSData*)readFileDataWithFilePath:(NSString *)filePath;

/// 追加数据
/// @param data 数据
/// @param fileName 文件名称
/// @param folderName 文件夹名称
/// @param type 沙盒目录路径类型
+(BOOL)appendData:(NSData*)data
         fileName:(NSString*)fileName
       folderName:(nullable NSString *)folderName
             type:(SandboxDirectoryType)type;

/// 写入文件
/// @param fileName 文件名称
/// @param folderName 文件夹名称
/// @param type 沙盒目录路径类型
/// @param data 数据
+(BOOL)writeToFile:(NSString*)fileName
        folderName:(nullable NSString *)folderName
              type:(SandboxDirectoryType)type
          contents:(NSData *)data;

/// 创建文件
/// @param fileName 文件名称
/// @param folderName 文件夹名称
/// @param type 沙盒目录路径类型
+(nullable NSString*)creatFileName:(NSString*)fileName
                        folderName:(nullable NSString*)folderName
                     directoryType:(SandboxDirectoryType)type;

@end

NS_ASSUME_NONNULL_END
