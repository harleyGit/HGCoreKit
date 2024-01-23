//
//  FileManager.m
//  MLC
//
//  Created by Harley Huang on 20/12/2022.
//  Copyright © 2022 HuangGang'sMac. All rights reserved.
//  文件操作: https://www.jianshu.com/p/086ca6d2c5de

#import "HGFileManager.h"
#import "TxtUtil.h"

@implementation HGFileManager




+(NSBundle *)sourceBundlePath {
    ///设置文件路径
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SourcesBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    ///或者如下:
    //NSBundle *bundle=[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"SourcesBundle" withExtension:@"bundle"]];
    return bundle;
}


+(NSDictionary*)getFileInfo:(NSString*)path {
    NSError *error;
    NSDictionary *reslut =  [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileInfo Failed:%@",[error localizedDescription]);
    }
    return reslut;
}

+(long long)getFileSizeWithFilePath:(NSString*)path {
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue]; //单位是 B
    }
    return fileLength;
}


+(void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep {
    NSArray *fileArray = nil;
    if (deep) {  // 是否深度遍历
        fileArray = [self getAllFileListWithFolderPath:path];
    }else{
        fileArray = [self getAllFileListWithFolderPath:path];
        NSMutableArray *fileArrayTmp = [NSMutableArray array];
        for (NSString *fileName in fileArray) {
            NSString* allPath = [path stringByAppendingPathComponent:fileName];
            [fileArrayTmp addObject:allPath];
        }
        fileArray = fileArrayTmp;
    }
    for (NSString *aPath in fileArray) {
        for (NSString* suffix in suffixList) {
            if ([aPath hasSuffix:suffix]) {
                [self removeFilePath:aPath];
            }
        }
    }
}


+(BOOL)removeDir:(NSString*)path {
    return [self removeFilePath:path];
}

+(BOOL)removeFilePath:(NSString*)filePath {
    BOOL isSuccess = NO;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    isSuccess = [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"removeFile Field：%@",[error localizedDescription]);
    }else{
        NSLog(@"removeFile Success");
    }
    return isSuccess;
}

+(BOOL)moveFile:(NSString *)fromPath
         toPath:(NSString *)toPath
    toPathIsDir:(BOOL)dir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fromPath]) {
        NSLog(@"Error: fromPath Not Exist");
        return NO;
    }
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            if ([self creatFolderName:toPath directoryType:SandboxDirectoryTypeDocuments]) {
                NSString *fileName = fromPath.lastPathComponent;
                toPath = [toPath stringByAppendingPathComponent:fileName];
                return [self moveItemAtPath:fromPath toPath:toPath];
            }
        }else{
            [self removeFilePath:toPath];
            return [self moveItemAtPath:fromPath toPath:toPath];
        }
    }
    else{
        if (dir) {
            if ([self creatFolderName:toPath directoryType:SandboxDirectoryTypeDocuments]) {
                NSString *fileName = fromPath.lastPathComponent;
                toPath = [toPath stringByAppendingPathComponent:fileName];
                return [self moveItemAtPath:fromPath toPath:toPath];
            }
        }else{
            return [self moveItemAtPath:fromPath toPath:toPath];
        }
    }
    return NO;
}


+(BOOL)moveItemAtPath:(NSString*)fromPath toPath:(NSString*)toPath{
    BOOL result = NO;
    NSError * error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    result = [fileManager moveItemAtPath:fromPath toPath:toPath error:&error];
    if (error){
        NSLog(@"moveFile Fileid：%@",[error localizedDescription]);
    }
    return result;
}

+(NSArray*)getAllFileListWithFolderPath:(NSString*)path{
    if (path.length==0) {
        return nil;
    }
    NSArray *fileArray = [self getFileListWithFolderPath:path];
    NSMutableArray *fileArrayNew = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *aPath in fileArray) {
        NSString * fullPath = [path stringByAppendingPathComponent:aPath];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDir]) {
            if (isDir) {
                [fileArrayNew addObjectsFromArray:[self getAllFileListWithFolderPath:fullPath]];
            }else{
                [fileArrayNew addObject:fullPath];
            }
        }
    }
    return fileArrayNew;
}


+(NSArray*)getFileListWithFolderPath:(NSString*)folderPath{
    if (folderPath.length==0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:folderPath error:&error];
    if (error) {
        NSLog(@"getFileList Failed:%@",[error localizedDescription]);
    }
    return fileList;
}


+(NSData*)readFileDataWithFilePath:(NSString *)filePath {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}


+(BOOL)appendData:(NSData*)data
         fileName:(NSString*)fileName
       folderName:(nullable NSString *)folderName
             type:(SandboxDirectoryType)type{
    if (!data) {
        return NO;
    }
    NSString *filePath = [self creatFileName:fileName folderName:folderName directoryType:type];
    if ([TxtUtil isEmptyWithTxt:filePath]) {
        return NO;
    }
    
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [handle seekToEndOfFile];
    [handle writeData:data];
    [handle synchronizeFile];
    [handle closeFile];
    
    return YES;
}


+(BOOL)writeToFile:(NSString*)fileName
        folderName:(nullable NSString *)folderName
              type:(SandboxDirectoryType)type
          contents:(NSData *)data{
    if (!data) {
        return NO;
    }
    NSString *filePath = [self creatFileName:fileName folderName:folderName directoryType:type];
    if ([TxtUtil isEmptyWithTxt:filePath]) {
        return NO;
    }
    
    BOOL isSuccess = [data writeToFile:filePath atomically:YES];
    
    return isSuccess;
}


/// 获取沙盒路径
/// @param type 沙盒文件夹类型
+ (NSString *)sandboxDirectoryPathWithType:(SandboxDirectoryType)type {
    NSDictionary<NSNumber*, NSString*> *pathDic = @{
        @(SandboxDirectoryTypeDocuments): [self sandboxDocumentPath],
        @(SandboxDirectoryTypeCaches): [self sandboxCachesPath],
        @(SandboxDirectoryTypePreferences): [self sandboxPreferencesPath],
        @(SandboxDirectoryTypeTmp): [self sandboxTmpPath]
    };
    
    return pathDic[@(type)];
}


/// 创建文件夹
/// @param folderName 文件夹名称
/// @param type 沙盒文件夹类型
+(nullable NSString *)creatFolderName:(NSString *)folderName
                        directoryType:(SandboxDirectoryType)type {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [self sandboxDirectoryPathWithType:type], folderName];
    
    if (path.length == 0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (isExist==NO) {
        NSError *error;
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"creat Directory Failed:%@",[error localizedDescription]);
            return nil;
        }
    }
    return path;
}

+(nullable NSString*)creatFileName:(NSString*)fileName
                        folderName:(nullable NSString*)folderName
                     directoryType:(SandboxDirectoryType)type {
    
    NSString *path = [self sandboxDirectoryPathWithType:type];
    if ([TxtUtil isEmptyWithTxt:path]) {
        return nil;
    }
    
    NSString *filePath = nil;
    if (folderName) {
        //路径后拼上想要创建的目录名
        filePath =[path stringByAppendingPathComponent:folderName];
    }
    filePath = [filePath stringByAppendingPathComponent:fileName];
    
    if (filePath.length == 0) {
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断该路径文件是否存在
    if ([fileManager fileExistsAtPath:filePath]) {
        return filePath;
    }
    NSError *error;
    //删除filePath路径的最后一个组成部分
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    //fileManager在dirPath路径上创建一个目录
    BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed:%@",[error localizedDescription]);
    }
    if (!isSuccess) {
        return nil;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return filePath;
}


///运行时生成的需要持久化的数据，iTunes备份和恢复的时候会包括此目录
+ (NSString *) sandboxDocumentPath {
    // 获取Document目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return docPath;
}

+ (NSString *) sandboxLibraryPath {
    // 获取Library目录
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    return  libraryPath;
}

///存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出后删除 。
///一般存放体积比较大，不是特别重要的资源
+ (NSString *) sandboxCachesPath {
    // 获取Caches目录
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return cachesPath;
}

///保存APP的所有偏好设置，iOS的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录
///注意：通过NSUserDefaults类来读取和设置。
+ (NSString *) sandboxPreferencesPath {
    NSString *libraryPath = [self sandboxLibraryPath];
    // 获取Preferences目录 通常情况下，Preferences有系统维护，所以我们很少去操作它。
    NSString *preferPath = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    
    return preferPath;
}

///保存应用运行时所需的临时数据，这个可以放一些当APP退出后不再需要的文件
///应用没有运行时，系统也有可能会清除该目录下的文件，iTunes不会同步该目录
///iPhone重启时，该目录下的文件会被删除。
+ (NSString *) sandboxTmpPath {
    // 获取tmp目录
    NSString *tmpPath = NSTemporaryDirectory();
    
    return tmpPath;
}



@end
