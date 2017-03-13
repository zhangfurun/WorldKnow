//
//  Choose.m
//  WorldKnow
//
//  Created by 张福润 on 16/3/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "Choose.h"
static Choose *choo=nil;
@implementation Choose
+(instancetype)shareWithChoose{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        choo=[[Choose alloc]init];
        
    });
    return choo;
}

-(NSString *)userChoose{
    if(!_userChoose){
        _userChoose=@"T1348647853363";
    }
    return _userChoose;
}

-(NSString *)title{
    if(!_title){
        _title=@"头条";
    }
    return _title;
}
@end
