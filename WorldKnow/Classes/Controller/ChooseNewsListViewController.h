//
//  ChooseNewsListViewController.h
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "WKBaseViewController.h"

#define SEGUEID @"segue_list"

typedef void(^backBlock) (NSMutableArray * arr);
@interface ChooseNewsListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
///当前选中的列表名称数组,用来交互传值
@property (nonatomic,strong)NSMutableArray * arr;
///存放全部列表的名字
@property (nonatomic,strong)NSArray * arrayAllListName;

@property (nonatomic,copy)backBlock block;

-(void)setBlock:(backBlock)block;

@end
