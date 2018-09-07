//
//  NewsItem.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseModel.h"

@interface NewsItem : WKBaseModel
///唯一标示id
@property (nonatomic, copy)NSString * postid;
///图片地址
@property (nonatomic, copy)NSString * imgsrc;
///标题
@property (nonatomic, copy)NSString * ltitle;
///摘要
@property (nonatomic, copy)NSString * digest;
//详情页面的url
@property (nonatomic, copy)NSString * url;
///多张图片的cell
@property (nonatomic, copy)NSArray * imgextra;
///多张图片的title
@property (nonatomic, copy)NSString * title;
///回复数
@property (nonatomic, copy)NSString * replyCount;

///详情页面
@property (nonatomic, copy)NSString * docid;
@end
