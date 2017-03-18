//
//  NewsListViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailViewController.h"

#import "NewsImagesCell.h"
#import "NewsListCell.h"

#import "NewsItem.h"

#import "Choose.h"
#import "MJRefresh.h"

#import "UIImageView+WebCache.h"

#define CELLID @"cell_id_first"

@interface NewsListViewController ()<UITableViewDelegate,UITableViewDataSource, NewsListCellDelegate, NewsImagesCellDelegate>
{
    NSInteger flag;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

///图片的数组
@property (nonatomic,strong)NSMutableArray * imageArray;
@end

@implementation NewsListViewController

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 0;
    self.navigationItem.title = [Choose shareWithChoose].title;
    [self getData:[Choose shareWithChoose].userChoose];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.timer invalidate];
        self.timer = nil;
        self.page.currentPage = 0;
        pageNumber = 0;
        self.scrollView.contentOffset=CGPointMake(0, 0);
        flag = 0;
        [self getData:[Choose shareWithChoose].userChoose];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.timer invalidate];
        self.timer = nil;
        pageNumber = 0;
        self.page.currentPage=0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        [self getData:[Choose shareWithChoose].userChoose];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Request
-(void)getData:(NSString *)sender{
    NSString *url;
    if(flag < 20){
        url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/%ld-20.html",sender,flag];
    }else {
        url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/20-%ld.html",sender,flag];
        
    }
    flag+=20;
    NSLog(@"url=%@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSDictionary *dicJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for(NSDictionary *dealsDic in dicJSON[sender]){
                NewsItem *model = [[NewsItem alloc]init];
                [model setValuesForKeysWithDictionary:dealsDic];
                //                if(model.docid.length>0&&model.imgsrc.length>0&&model.digest.length>0&&model.ltitle.length>0){
                if(([model.replyCount integerValue] > 50) && (self.arrToutiao.count < 6)){
                    [self.arrToutiao addObject:dealsDic];
                }
                if(![self.arrayAllData containsObject:model]){
                    [self.arrayAllData addObject:model];
                }
                //                }
            }
            dispatch_after(0, dispatch_get_main_queue(), ^{
                if(self.arrToutiao.count > 0){
                    self.tableView.tableHeaderView = [self headerCustom];
                    self.tableView.tableHeaderView.translatesAutoresizingMaskIntoConstraints=YES;
                }
                [self endRefresh];
                [self.tableView reloadData];
            });
        }
    }];
    //执行
    [task resume];
}

#pragma mark - Methods
- (NSMutableArray *)arrayAllData{
    if(!_arrayAllData){
        _arrayAllData=[NSMutableArray array];
        
    }
    return _arrayAllData;
}

- (NSMutableArray *)arrToutiao{
    if(!_arrToutiao){
        _arrToutiao=[NSMutableArray array];
    }
    return _arrToutiao;
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (UIView *)headerCustom{
    if(self.arrToutiao.count>0){
        UIView *viewCustom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWith, 200)];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWith, 200)];
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWith, 200)];
        self.scrollView.contentSize = CGSizeMake(kWith*self.arrToutiao.count, 0);
        self.scrollView.pagingEnabled=YES;
        for(int i = 0;i < self.arrToutiao.count; i++){
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*kWith, 0, kWith, 200)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrToutiao[i][@"imgsrc"]]];
            [self.scrollView addSubview:imageView];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [viewCustom addGestureRecognizer:tap];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.arrToutiao.count*kWith, 0, kWith, 200)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.arrToutiao.firstObject[@"imgsrc"]]];
        [self.scrollView addSubview:imageView];
        
        self.page = [[UIPageControl alloc]initWithFrame:CGRectMake((kWith) - self.arrToutiao.count * 20, 200 - 15, (self.arrToutiao.count * 20), 15)];
        //        self.page.backgroundColor = [UIColor redColor];
        self.page.numberOfPages = self.arrToutiao.count;
        self.page.pageIndicatorTintColor = [UIColor redColor];
        
        //蒙版
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 200 - 30, kWith, 30)];
        self.labelHeaderTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 200 - 30, (kWith) - self.arrToutiao.count * 20 - 10, 30)];
        self.labelHeaderTitle.textColor = [UIColor whiteColor];
        
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        [self.imageView addSubview:self.scrollView];
        [self.imageView addSubview:label];
        [self.imageView addSubview:self.page];
        
        [self.imageView addSubview:self.labelHeaderTitle];
        
        self.imageView.userInteractionEnabled = YES;
        [viewCustom addSubview:self.imageView];
        self.labelHeaderTitle.text = self.arrToutiao[((int)(self.scrollView.contentOffset.x)) % (self.arrToutiao.count * ((int)kWith)) / ((int)kWith)][@"title"];
        
        self.scrollView.delegate=self;
        
        if(self.arrToutiao.count > 1){
            self.timer= [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        }
        return viewCustom;
    }
    else{
        return nil;
    }
}

#pragma mark - Selector
// 点击头视图
- (void)tapAction:(UIImageView *)sender{
    NSLog(@"%ld",((int)self.scrollView.contentOffset.x)%(self.arrToutiao.count*(int)kWith)/(int)kWith);
    [self performSegueWithIdentifier:@"segue_header" sender:self];
}

// 定时器,banner
- (void)timeAction:(NSTimer *)sender{
    pageNumber++;
    if(pageNumber == (self.arrToutiao.count+1)){
        pageNumber = 0;
        [self.scrollView setContentOffset:CGPointMake(pageNumber++ * kWith, 0) animated:NO];
    }
    
    if(pageNumber == self.arrToutiao.count){
        self.page.currentPage = 0;
        self.labelHeaderTitle.text = self.arrToutiao[self.page.currentPage][@"title"];
    }
    else{
        self.page.currentPage = pageNumber;
        self.labelHeaderTitle.text = self.arrToutiao[self.page.currentPage][@"title"];
    }
    
    [self.scrollView setContentOffset:CGPointMake(pageNumber * kWith, 0) animated:YES];
}

#pragma mark - Segue Action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //点击cell
    if ([segue.identifier isEqualToString:@"segue_news"] || [segue.identifier isEqualToString:@"segue_image"]){
        NewsListCell *cell = (NewsListCell *)sender;
        NSIndexPath *index = [self.tableView indexPathForCell:cell];
        id des = segue.destinationViewController;
        NewsItem *model = self.arrayAllData[index.row] ;
        [des setValue:model.docid forKey:@"postid"];
        [des setValue:model forKey:@"model"];
    }
    
    else{
        //点击轮播图
        if([segue.identifier isEqualToString:@"segue_header"]){
            NewsItem *model = [[NewsItem alloc]init];
            int a = ((int)self.scrollView.contentOffset.x) % (self.arrToutiao.count * (int)kWith) / (int)kWith;
            [model setValuesForKeysWithDictionary: self.arrToutiao[a]];
            
            id des = segue.destinationViewController;
            [des setValue:model.postid forKey:@"postid"];
            [des setValue:model forKey:@"model"];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayAllData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsItem *model =self.arrayAllData[indexPath.row];
    
    if(model.imgextra.count > 0) {
        NewsImagesCell *cell = [NewsImagesCell cellWithTableView:tableView];
        cell.item = model;
        cell.delegate = self;
        return cell;
    }else{
        NewsListCell *cell = [NewsListCell cellWithTableView:tableView];
        cell.item = model;
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsItem *model =self.arrayAllData[indexPath.row];
    if(model.imgextra.count > 0){
        return 126;
    }
    else{
        return 98;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath;
}

#pragma mark - NewsListCellDelegate
- (void)newsListCell:(NewsListCell *)cell didSelectedWithItem:(NewsItem *)item {
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    newsDetailVC.newsListItem = item;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark - NewsImagesCellDelegate
- (void)newsImagesCell:(NewsImagesCell *)cell didSelectedWithItem:(NewsItem *)item {
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    newsDetailVC.newsListItem = item;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}
@end
