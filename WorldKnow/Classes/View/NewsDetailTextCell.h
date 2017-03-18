//
//  NewsDetailTextCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/18.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseTableViewCell.h"

@class NewsDetailItem;
@class NewsDetailTextCell;

@protocol NewsDetailTextCellDelegate <NSObject>

@optional
- (void)newsDetailTextCell:(NewsDetailTextCell *)cell didSharedWithItem:(NewsDetailItem *)item;

@end

@interface NewsDetailTextCell : WKBaseTableViewCell
@property (strong, nonatomic) NewsDetailItem *detailItem;
@property (weak, nonatomic) id<NewsDetailTextCellDelegate> delegate;
@end
