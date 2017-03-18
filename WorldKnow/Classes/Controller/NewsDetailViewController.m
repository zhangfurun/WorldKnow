//
//  NewsDetailViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/17.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "NewsDetailTextCell.h"
#import "NewsDetailImageCell.h"
#import "NewsDetailWebCell.h"

#import "NewsItem.h"
#import "NewsDetailItem.h"

#import "DataBase.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

#import "UIImageView+WebCache.h"

#define CELLID @"cell_id_firstDetil"

@interface NewsDetailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemCollection;
@property (weak, nonatomic) IBOutlet UIButton *buttonModelBack;

///当前数据Model
@property (nonatomic, strong)NewsDetailItem * detailItem;


@end

@implementation NewsDetailViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
    [self setDelegate];
    [self getDetailDataRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    if(userName){
        [[DataBase shareDataBase]openDBWithTable:userName];
        NSArray *arr= [[DataBase shareDataBase]selectWithTableName:userName];
        for(NewsItem *model in arr){
            if([model.postid isEqualToString:self.newsListItem.postid]){
                [self.itemCollection setImage:[UIImage imageNamed:@"已收藏"]];
            }
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[DataBase shareDataBase]closeDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request
- (void)getDetailDataRequest {
    NSString *url=[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.newsListItem.postid];
    NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSDictionary *dicJSON=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.detailItem setValuesForKeysWithDictionary:dicJSON[self.newsListItem.postid]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    //执行
    [task resume];
}

#pragma mark - Methods
- (NewsDetailItem *)detailItem{
    if(!_detailItem){
        _detailItem = [[NewsDetailItem alloc]init];
    }
    return _detailItem;
}

-(void)setViews{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
}

-(void)setDelegate{
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - Action
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)shareAction:(id)sender {
//
//    [UMSocialData defaultData].extConfig.wechatSessionData.url =self.model.url;
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:YMAPPID
//                                      shareText:[NSString stringWithFormat:@"[天下通分享],%@ %@",self.detilModel.title,self.model.url]
//                                     shareImage: self.imageShare
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil]
//                                       delegate:self];
//
//
//
//}

- (IBAction)collectionAction:(id)sender {
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    if(!userName){
        [self performSegueWithIdentifier:@"segue_noLogin" sender:self];
    }else{
        
        if([[DataBase shareDataBase]addWithNews:self.newsListItem tableName:userName]){
            NSLog(@"%ld",[[DataBase shareDataBase] selectWithTableName:userName].count);
            [self.itemCollection setImage:[UIImage imageNamed:@"已收藏"]];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailItem.img.count + 1 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NewsDetailTextCell *cell = [NewsDetailTextCell cellWithTableView:tableView];
        cell.detailItem = self.detailItem;
        return cell;
    }else {
        if(indexPath.row > 0 && indexPath.row < self.detailItem.img.count + 1){
            NewsDetailImageCell *cell = [NewsDetailImageCell cellWithTableView:tableView];
            cell.imageUrl = self.detailItem.img[indexPath.row - 1][@"src"];
            cell.title = self.detailItem.img[indexPath.row - 1][@"alt"];
            if(indexPath.row == 1 && self.detailItem.img.count > 0){
                self.imageShare = cell.shareImage;
            }
            return cell;
        }else {
            NewsDetailWebCell *cell = [NewsDetailWebCell cellWithTableView:tableView];
            cell.webString = self.detailItem.body;
            return cell;
        }
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 90;
//    }else {
//        if(indexPath.row > 0 && indexPath.row < self.detailItem.img.count + 1){
//            return 120;
//        }else {
//            return 116;
//        }
//    }
//}
@end
