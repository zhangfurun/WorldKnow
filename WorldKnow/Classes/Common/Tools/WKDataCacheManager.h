//
//  WKDataCacheManager.h
//  WorldKnow
//
//  Created by ifenghui on 2018/9/7.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsItem;

@interface WKDataCacheManager : NSObject
+ (void)initCacheManagerFolder;
+ (void)newsDetailCache:(NewsItem *)newItem;
+ (NewsItem *)getNewsDetail;
@end
