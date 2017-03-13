//
//  FirstDetilModel.h
//  WorldKnow
//
//  Created by 张福润 on 16/2/20.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstDetilModel : NSObject
///文字新闻
@property (nonatomic,strong)NSString * body;
///报到时间
@property (nonatomic,strong)NSString * ptime;
///标题
@property (nonatomic,strong)NSString * title;
///报道来源
@property (nonatomic,strong)NSString * source;
///图片
@property (nonatomic,strong)NSArray * img;
@end
