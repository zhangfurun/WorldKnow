//
//  Choose.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Choose : NSObject

@property (nonatomic,strong)NSString * userChoose;
@property (nonatomic,strong)NSString * title;

+(instancetype)shareWithChoose;
@end
