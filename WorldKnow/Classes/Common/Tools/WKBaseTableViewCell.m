//
//  WKBaseTableViewCell.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/17.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseTableViewCell.h"

#import "UIView+TTSuperView.h"

@interface WKBaseTableViewCell ()

@end

@implementation WKBaseTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    id cell = [tableView dequeueReusableCellWithIdentifier:[self getIdentifier]];
    if (!cell) {
        cell = [self loadFromNib];
    }
    return cell;
}

+ (NSString *)getIdentifier {
    return NSStringFromClass([self class]);
}
@end
