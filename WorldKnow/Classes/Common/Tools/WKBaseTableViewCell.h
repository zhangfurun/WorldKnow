//
//  WKBaseTableViewCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/17.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKBaseTableViewCell : UITableViewCell
@property (strong, nonatomic) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
