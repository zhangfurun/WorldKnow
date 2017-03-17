//
//  NewsImagesCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseTableViewCell.h"

@class NewsItem;
@class NewsImagesCell;

@protocol NewsImagesCellDelegate <NSObject>

@optional
- (void)newsImagesCell:(NewsImagesCell *)cell didSelectedWithItem:(NewsItem *)item;

@end

@interface NewsImagesCell : WKBaseTableViewCell
@property (strong, nonatomic) NewsItem *item;
@property (weak, nonatomic) id<NewsImagesCellDelegate> delegate;

@end
