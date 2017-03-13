//
//  FirstModel.h
//  WorldKnow
//
//  Created by 张福润 on 16/2/3.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject
///唯一标示id
@property (nonatomic,strong)NSString * postid;
///图片地址
@property (nonatomic,strong)NSString * imgsrc;
///标题
@property (nonatomic,strong)NSString * ltitle;
///摘要
@property (nonatomic,strong)NSString * digest;
//详情页面的url
@property (nonatomic,strong)NSString * url;
///多张图片的cell
@property (nonatomic,strong)NSArray * imgextra;
///多张图片的title
@property (nonatomic,strong)NSString * title;
///回复数
@property (nonatomic,strong)NSString * replyCount;

///详情页面
@property (nonatomic,strong)NSString * docid;
@end
