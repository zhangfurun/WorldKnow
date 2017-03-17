//
//  NewsListViewController.h
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListViewController : UIViewController
{
    int pageNumber;
}
@property (nonatomic,strong)NSMutableArray * arrayAllData;
@property (nonatomic,strong)NSIndexPath * index;
@property (nonatomic,strong)NSString * titlea;
@property (nonatomic,strong)NSString * number;



@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIPageControl * page;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * labelHeaderTitle;



///头条的数组
@property (nonatomic,strong)NSMutableArray * arrToutiao;
@property (nonatomic,strong)NSMutableArray * docid;


@property (nonatomic,strong)NSTimer * timer;
@end
