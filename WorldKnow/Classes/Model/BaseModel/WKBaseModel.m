//
//  WKBaseModel.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "WKBaseModel.h"

@implementation WKBaseModel

//重写以下几个方法
- (void)encodeWithCoder:(NSCoder*)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone*)zone {
    return [self modelCopy];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

@end
