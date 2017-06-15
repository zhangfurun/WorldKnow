//
//  LeftViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "LeftViewController.h"
#import "PickViewController.h"
#import "ListViewController.h"
#import "NewsListViewController.h"

#import "Choose.h"
#import "RESideMenu.h"
#import "AllListName.h"

#import "UIViewController+RESideMenu.h"

#define CELLID @"cell_id_Left"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel; //当前温度
@property (weak, nonatomic) IBOutlet UILabel *refreshTime; //更新时间
@property (weak, nonatomic) IBOutlet UILabel *labelWeather; //天气
@property (weak, nonatomic) IBOutlet UILabel *labelWind; //风向
@property (weak, nonatomic) IBOutlet UILabel *labelWindLevel; //风级
@property (weak, nonatomic) IBOutlet UILabel *labelTemp; //温度
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftViewController
- (IBAction)changeLocationAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationBtn.layer.cornerRadius = 5;
    self.locationBtn.layer.masksToBounds = YES;
    self.locationBtn.backgroundColor = [UIColor colorWithRed:44/255.0 green:178/255.0 blue:219/255.0 alpha:1.0];
    self.locationBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    self.locationBtn.layer.shadowOpacity = 0.8;
    self.locationBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    //    self.arrData = @[@"热点",@"娱乐",@"科技"];
  
    [self.arrData addObjectsFromArray:@[@"头条", @"娱乐", @"科技", @"财经", @"健康", @"时尚"]];
}

#pragma mark - Methods
- (NSMutableArray *)arrData{
    if(!_arrData){
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

- (void)reloadWeather:(CityModel *)model{
    self.labelTemp.text = [NSString stringWithFormat:@"%@℃~%@℃",model.l_tmp,model.h_tmp];
    self.currentTempLabel.text = model.temp;
    self.refreshTime.text = model.time;
    self.labelWind.text = model.WD;
    self.labelWindLevel.text = model.WS;
    self.labelWeather.text = model.weather;
    [self.locationBtn setTitle:model.city forState:(UIControlStateNormal)];
}

#pragma mark - Action
- (IBAction)onAddBtnTap:(UIButton *)sender {
    ListViewController *list = [ListViewController new];
    [list setValue:self.arrData forKey:@"arr"];
    __weak typeof(self) WS = self;
    [list setBlock:^(NSMutableArray *arr){
        WS.arrData = arr;
        [WS.tableView reloadData];
    }];
}

- (IBAction)onLocationBtnTap:(UIButton *)sender {
    PickViewController *pick = [PickViewController new];
    __weak typeof(self) WS = self;
    [pick setCityWeatherBlcok:^(CityModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WS.model = model;
            [WS reloadWeather:model];   
        });
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID ];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CELLID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = self.arrData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [AllListName shareAllList].getAllList;
    
    [Choose shareWithChoose].title = self.arrData[indexPath.row];
    [Choose shareWithChoose].userChoose = dic[self.arrData[indexPath.row]];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[NewsListViewController new]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

