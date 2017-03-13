//
//  AllListName.m
//  WorldKnow
//
//  Created by 张福润 on 16/3/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "AllListName.h"
static AllListName *all=nil;
@implementation AllListName
+(instancetype)shareAllList{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        all=[[AllListName alloc]init];
        
    });
    return all;
}

-(NSDictionary *)getAllList{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"NewsList" ofType:@"plist"];
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
    return dic;

}
@end
