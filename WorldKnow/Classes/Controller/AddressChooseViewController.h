//
//  AddressChooseViewController.h
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "WKBaseViewController.h"

@class CityModel;

typedef void(^cityWeatherBlock) (CityModel *model);
@interface AddressChooseViewController : UIViewController
@property (nonatomic,strong)NSString * districtNameStr;
@property (nonatomic,strong)NSString * districtNumberStr;
@property (nonatomic,strong)CityModel * cityModel;
@property (nonatomic,strong)cityWeatherBlock  block;

-(void)setCityWeatherBlcok:(cityWeatherBlock)block;
@end
