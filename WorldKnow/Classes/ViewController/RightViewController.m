//
//  RightViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ImageViewUserHeader;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoginOrCanel;
@property (weak, nonatomic) IBOutlet UIButton *buttonCollection;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;


@end

@implementation RightViewController
- (IBAction)tapAction:(id)sender {
}
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    
    if([user boolForKey:@"login"]){
        [self.buttonLoginOrCanel setImage:[UIImage imageNamed:@"注销"] forState:(UIControlStateNormal)];
        
        if([user objectForKey:@"userNameLable"]){
            self.labelUserName.text=[user objectForKey:@"userNameLable"];
        }
        else{
            self.labelUserName.text=[user objectForKey:@"userName"];
        }
    }
    else{
        [self.buttonLoginOrCanel setImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateNormal)];
        self.labelUserName.text=@"";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    
    self.ImageViewUserHeader.layer.cornerRadius=150/2;
    self.ImageViewUserHeader.layer.masksToBounds=YES;
    //    self.ImageViewUserHeader.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (IBAction)loginAction:(id)sender {
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if([user boolForKey:@"login"]){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"确定注销?" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *actionExit=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self performSelectorOnMainThread:@selector(mainAction:) withObject:user waitUntilDone:YES];
        }];
        UIAlertAction *actioncancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actioncancel];
        [alert addAction:actionExit];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        
        
        [self performSegueWithIdentifier:@"segue_loginOeCancel" sender:self];
    }
    
}

-(void)mainAction:(NSUserDefaults *)user{
    self.labelUserName.text=@"";
    [user removeObjectForKey:@"userName"];
    [user setBool:NO forKey:@"login"];
    [self.buttonLoginOrCanel setImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateNormal)];
}
- (IBAction)collectionAction:(id)sender {
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    NSString *userName=[user objectForKey:@"userName"];
    if(userName){
        [self performSegueWithIdentifier:@"segue_id_collectionWithLogin" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"segue_loginOeCancel" sender:self];
    }
    
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

