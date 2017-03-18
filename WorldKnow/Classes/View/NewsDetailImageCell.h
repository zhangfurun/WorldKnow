//
//  NewsDetailImageCell.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/18.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseTableViewCell.h"

@class NewsDetailItem;

@interface NewsDetailImageCell : WKBaseTableViewCell
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic, readonly) UIImage *shareImage;
@end
