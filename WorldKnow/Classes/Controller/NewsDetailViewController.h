//
//  NewsDetailViewController.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/17.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "WKBaseViewController.h"

@class NewsItem;
@class NewsDetailItem;

@interface NewsDetailViewController : WKBaseViewController
@property (nonatomic,strong)NewsItem * newsListItem;
///要分享的image
@property (nonatomic,strong)UIImage * imageShare;

@end
