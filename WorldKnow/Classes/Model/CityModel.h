//
//  CityModel.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/9.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
///最高气温
@property (nonatomic,strong)NSString * h_tmp;
///最低气温
@property (nonatomic,strong)NSString * l_tmp;
///风向
@property (nonatomic,strong)NSString * WD;
///更新时间
@property (nonatomic,strong)NSString * time;
///风力
@property (nonatomic,strong)NSString * WS;
///天气
@property (nonatomic,strong)NSString * weather;
///当前温度
@property (nonatomic,strong)NSString * temp;
///城市
@property (nonatomic,strong)NSString * city;









@end
