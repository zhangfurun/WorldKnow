//
//  UIViewController+UIViewControllerInitWithXib.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "UIViewController+UIViewControllerInitWithXib.h"

@implementation UIViewController (UIViewControllerInitWithXib)
+ (id)initWithXib {
    id viewController = [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
    return viewController ? : [[self alloc] init];
}
@end
