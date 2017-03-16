//
//  PickViewController.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/9.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityModel;

typedef void(^cityWeatherBlock) (CityModel *model);
@interface PickViewController : UIViewController
@property (nonatomic,strong)NSString * districtNameStr;
@property (nonatomic,strong)NSString * districtNumberStr;
@property (nonatomic,strong)CityModel * cityModel;
@property (nonatomic,strong)cityWeatherBlock  block;

-(void)setCityWeatherBlcok:(cityWeatherBlock)block;
@end
