//
//  LeftViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "LeftViewController.h"
#define CELLID @"cell_id_Left"
#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"
#import "NewsListViewController.h"
#import "Choose.h"
#import "ListViewController.h"
#import "AllListName.h"
#import "PickViewController.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelRefreshTime;
@property (weak, nonatomic) IBOutlet UILabel *labelWeather;
@property (weak, nonatomic) IBOutlet UILabel *labelWind;
@property (weak, nonatomic) IBOutlet UILabel *labelWindLevel;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;
@property (weak, nonatomic) IBOutlet UIButton *buttonLocation;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

@end

@implementation LeftViewController
- (IBAction)changeLocationAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttonLocation.layer.cornerRadius=5;
    self.buttonLocation.layer.masksToBounds=YES;
    self.buttonLocation.backgroundColor=[UIColor colorWithRed:44/255.0 green:178/255.0 blue:219/255.0 alpha:1.0];
    self.buttonLocation.layer.shadowOffset =  CGSizeMake(1, 1);
    self.buttonLocation.layer.shadowOpacity = 0.8;
    self.buttonLocation.layer.shadowColor =  [UIColor blackColor].CGColor;
    //    self.arrData=@[@"热点",@"娱乐",@"科技"];
    [self.arrData addObject:@"头条"];
    [self.arrData addObject:@"娱乐"];
    [self.arrData addObject:@"科技"];
    [self.arrData addObject:@"财经"];
    [self.arrData addObject:@"健康"];
    [self.arrData addObject:@"时尚"];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CELLID ];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CELLID];
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.backgroundColor=[UIColor clearColor];
    
    cell.textLabel.text=self.arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *dic=[AllListName shareAllList].getAllList;
    
    [Choose shareWithChoose].title=self.arrData[indexPath.row];
    [Choose shareWithChoose].userChoose=dic[self.arrData[indexPath.row]];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segue_list"]){
        
        
        ListViewController *list=segue.destinationViewController;
        [list setValue:self.arrData forKey:@"arr"];
        __weak LeftViewController *weakSelf =self;
        [list setBlock:^(NSMutableArray *arr){
            weakSelf.arrData=arr;
            [weakSelf.tableView reloadData];
        }];
        
    }
    if([segue.identifier isEqualToString:@"segue_place"]){
        PickViewController *pick=segue.destinationViewController;
        __weak LeftViewController *weakSelf =self;
        [pick setCityWeatherBlcok:^(CityModel *model) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model=model;
                [weakSelf reloadWeather:model];
            });
            
            
        }];
    }
    
}

-(void)reloadWeather:(CityModel *)model{
    self.labelTemp.text=[NSString stringWithFormat:@"%@℃~%@℃",model.l_tmp,model.h_tmp];
    self.labelCurrentTemp.text=model.temp;
    self.labelRefreshTime.text=model.time;
    self.labelWind.text=model.WD;
    self.labelWindLevel.text=model.WS;
    self.labelWeather.text=model.weather;
    [self.buttonLocation setTitle:model.city forState:(UIControlStateNormal)];
}
#pragma mark - 懒加载
-(NSMutableArray *)arrData{
    if(!_arrData){
        _arrData=[NSMutableArray array];
    }
    return _arrData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

