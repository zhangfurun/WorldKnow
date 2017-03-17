//
//  NewsDetailViewController.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/17.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;
@class FirstDetilModel;

@interface NewsDetailViewController : UIViewController
@property (nonatomic,strong)NewsItem * model;

///当前数据Model
@property (nonatomic,strong)FirstDetilModel * detilModel;

@property (nonatomic,strong)NSString * postid;

///要分享的image
@property (nonatomic,strong)UIImage * imageShare;

@end
