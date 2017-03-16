//
//  ListViewController.h
//  WorldKnow
//
//  Created by 张福润 on 16/3/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SEGUEID @"segue_list"

typedef void(^backBlock) (NSMutableArray * arr);
@interface ListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
///当前选中的列表名称数组,用来交互传值
@property (nonatomic,strong)NSMutableArray * arr;
///存放全部列表的名字
@property (nonatomic,strong)NSArray * arrayAllListName;

@property (nonatomic,copy)backBlock block;

-(void)setBlock:(backBlock)block;

@end
