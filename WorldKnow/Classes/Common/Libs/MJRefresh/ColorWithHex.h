//
//  ColorWithHex.h
//  PCNews
//
//  Created by PengchengWang on 16/3/3.
//  Copyright © 2016年 pengchengWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorWithHex : NSObject
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
