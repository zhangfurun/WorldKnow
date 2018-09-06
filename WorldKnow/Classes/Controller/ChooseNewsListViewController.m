//
//  ChooseNewsListViewController.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "ChooseNewsListViewController.h"
#import "LeftViewController.h"
#import "ListCollectionViewCell.h"
#import "AllListName.h"
@interface ChooseNewsListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation ChooseNewsListViewController
-(NSArray *)arrayAllListName{
    if(!_arrayAllListName){
        _arrayAllListName=[NSArray array];
    }
    return _arrayAllListName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.arr=[NSMutableArray arrayWithObjects:@"科技",@"财经", nil];
    NSDictionary *dic=[AllListName shareAllList].getAllList;
    self.arrayAllListName=dic.allKeys;
    
    
    // Do any additional setup after loading the view.
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayAllListName.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell_collection_list" forIndexPath:indexPath];
    
    if([self.arr containsObject:self.arrayAllListName[indexPath.row]]){
        cell.labelListName.layer.borderColor=[UIColor redColor].CGColor;
    }
    cell.labelListName.text=self.arrayAllListName[indexPath.row];
    cell.labelListName.layer.cornerRadius=10;
    cell.labelListName.layer.masksToBounds=YES;
    cell.labelListName.layer.borderWidth=1;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ListCollectionViewCell *cell=(ListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if(cell.labelListName.layer.borderColor==[UIColor redColor].CGColor){
        
        cell.labelListName.layer.borderColor=[UIColor blackColor].CGColor;
        cell.labelListName.textColor=[UIColor blackColor];
        [self.arr removeObject:cell.labelListName.text];
    }
    else{
        cell.labelListName.layer.borderColor=[UIColor redColor].CGColor;
        cell.labelListName.textColor=[UIColor redColor];
        [self.arr addObject:cell.labelListName.text];
    }
}


- (IBAction)backAction:(id)sender {
    self.block(self.arr);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)setBlock:(backBlock)block{
    _block=block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
