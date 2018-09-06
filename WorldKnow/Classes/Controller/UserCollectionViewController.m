//
//  UserCollectionViewController.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "UserCollectionViewController.h"
#import "DataBase.h"
#import "NewsDetailViewController.h"
//#import "CollectionTableViewCell.h"
@interface UserCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *index;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;

@end

@implementation UserCollectionViewController
- (IBAction)editAction:(id)sender {
    self.editing=!self.editing;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing];
    [self.buttonEdit setTitle:editing?@"完成":@"删除" forState:(UIControlStateNormal)];
}
//是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.editing;
}

//返回编辑状态(删除)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//提交编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *userName=[user valueForKey:@"userName"];
    if(userName){
        NewsItem *model=self.arrayAlldata[indexPath.row];
        [[DataBase shareDataBase]delecteWithPocid:model.postid tableName:userName];
        [self.arrayAlldata removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}







- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor clearColor];
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    [[DataBase shareDataBase]openDBWithTable:userName];
    self.arrayAlldata=[[DataBase shareDataBase]selectWithTableName:userName
                       ];
    NSLog(@"%ld",self.arrayAlldata.count);
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    [[DataBase shareDataBase]closeDB];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayAlldata.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id_collection"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell_id_collection"];
    }
    NewsItem *model=self.arrayAlldata[indexPath.row];
    cell.textLabel.text=model.ltitle;
    cell.detailTextLabel.text=model.digest;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWith, 80)];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的收藏"]];
    imageView.center=CGPointMake(kWith/2, 40);
    //图片渲染
    imageView.image = [imageView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    imageView.tintColor = [UIColor blackColor];
    [view addSubview:imageView];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    index=indexPath;
    [self performSegueWithIdentifier:@"segue_collection_to_detil" sender:self];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id des = segue.destinationViewController;
    NewsItem *model=self.arrayAlldata[index.row];
    NSLog(@"model.postid=%@",model.postid);
    [des setValue:model.postid forKey:@"postid"];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(NSMutableArray *)arrayAlldata{
    if(!_arrayAlldata){
        _arrayAlldata=[NSMutableArray array];
    }
    return _arrayAlldata;
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

