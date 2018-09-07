//
//  WKDataCacheManager.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/7.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "WKDataCacheManager.h"

#import "WKConst.h"

#import "NSFileManager+TTFileManager.h"

static NSString * const WK_DataCache_Folder_Name = @"wkdatacachefolder";

@implementation WKDataCacheManager
+ (void)initCacheManagerFolder {
    NSString *folderPath = [kCachePath stringByAppendingPathComponent:WK_DataCache_Folder_Name];
    if (![NSFileManager isDirectoryExist:folderPath]) {
        [NSFileManager createDirectorysAtPath:folderPath];
    }
}

+ (void)newsDetailCache:(NewsItem *)newItem {
    NSString *folderPath = [kCachePath stringByAppendingPathComponent:WK_DataCache_Folder_Name];
    NSString *filePath = [folderPath stringByAppendingPathComponent:@"newsDetail.data"];
    BOOL ret =  [NSKeyedArchiver archiveRootObject:newItem toFile:filePath];
    
    if (ret) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }
    
}

+ (NewsItem *)getNewsDetail {
    NSString *folderPath = [kCachePath stringByAppendingPathComponent:WK_DataCache_Folder_Name];
    NSString *filePath = [folderPath stringByAppendingPathComponent:@"newsDetail.data"];
    NewsItem *news =[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return news;

}
@end
