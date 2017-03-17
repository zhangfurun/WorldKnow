//
//  NewsListCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseTableViewCell.h"

@class NewsItem;
@class NewsListCell;

@protocol NewsListCellDelegate <NSObject>

@optional
- (void)newsListCell:(NewsListCell *)cell didSelectedWithItem:(NewsItem *)item;

@end

@interface NewsListCell : WKBaseTableViewCell
@property (strong, nonatomic) NewsItem *item;
@property (weak, nonatomic) id<NewsListCellDelegate> delegate;

@end
