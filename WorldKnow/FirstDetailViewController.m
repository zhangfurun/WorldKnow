//
//  FirstDetailViewController.m
//  WorldKnow
//
//  Created by 张福润 on 16/2/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "FirstDetailViewController.h"
#define CELLID @"cell_id_firstDetil"
#import "UIImageView+WebCache.h"
#import "TitleTableViewCell.h"
#import "ImageTableViewCell.h"
#import "WebViewTableViewCell.h"
#import "DataBase.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>


@interface FirstDetailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemCollection;
@property (weak, nonatomic) IBOutlet UIButton *buttonModelBack;


@end

@implementation FirstDetailViewController
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

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
    [self setDelegate];
    [self setData];
    
    // Do any additional setup after loading the view.
}


-(FirstDetilModel *)detilModel{
    if(!_detilModel){
        _detilModel=[[FirstDetilModel alloc]init];
    }
    return _detilModel;
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    if(userName){
        [[DataBase shareDataBase]openDBWithTable:userName];
      NSArray *arr= [[DataBase shareDataBase]selectWithTableName:userName];
        for(FirstModel *model in arr){
            if([model.postid isEqualToString:self.model.postid]){
                [self.itemCollection setImage:[UIImage imageNamed:@"已收藏"]];
            }
        }
        
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [[DataBase shareDataBase]closeDB];
}
- (IBAction)collectionAction:(id)sender {
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    if(!userName){
        [self performSegueWithIdentifier:@"segue_noLogin" sender:self];
    }else{
    
    if([[DataBase shareDataBase]addWithNews:self.model tableName:userName]){
        NSLog(@"%ld",[[DataBase shareDataBase] selectWithTableName:userName].count);
        [self.itemCollection setImage:[UIImage imageNamed:@"已收藏"]];
        
    }
    
    
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TitleTableViewCell *cell_title=[tableView dequeueReusableCellWithIdentifier:@"cell_id_newsTitle" ];
    ImageTableViewCell *cell_img=[tableView dequeueReusableCellWithIdentifier:@"cell_id_image"];
    WebViewTableViewCell *cell_web=[tableView dequeueReusableCellWithIdentifier:@"cell_id_webView"];
    
    if(indexPath.row==0){
        
        cell_title.labelTitle.text=self.detilModel.title;
        cell_title.labelCome.text=self.detilModel.source;
        cell_title.labelTime.text=self.detilModel.ptime;
        return cell_title;
    }
    else{
        if(indexPath.row>0&&indexPath.row<self.detilModel.img.count+1){
            
            
            [cell_img.imV sd_setImageWithURL:[NSURL URLWithString:self.detilModel.img[indexPath.row-1][@"src"]]];
            if(indexPath.row==1&&self.detilModel.img.count>0){
            self.imageShare=cell_img.imV.image;
            }
            cell_img.labelImageTitle.text=self.detilModel.img[indexPath.row-1][@"alt"];
            
            return cell_img;
        }
        else{

            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.detilModel.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            cell_web.labelBody.attributedText = attrStr;
            return cell_web;
        }
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.detilModel.img.count+1+1;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)setViews{
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=2;
    
    
}

-(void)setDelegate{
    
    
}


-(void)setData{
    NSString *url=[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.postid];
    NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(data){
            NSDictionary *dicJSON=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.detilModel setValuesForKeysWithDictionary:dicJSON[self.postid]];
        
            dispatch_async(dispatch_get_main_queue(), ^{


                [self.tableView reloadData];
                
            });
        }
        
    }];
    //执行
    [task resume];
    
    
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
