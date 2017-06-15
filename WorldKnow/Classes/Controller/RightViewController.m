//
//  RightViewController.m
//  WorldKnow
//
//  Created by 张福润 on 2017/3/14.
//  Copyright © 2017年 张福润. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation RightViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userHeaderImageView.layer.cornerRadius=150/2;
    self.userHeaderImageView.layer.masksToBounds=YES;
    //    self.ImageViewUserHeader.backgroundColor=[UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    if([user boolForKey:@"login"]){
        [self.loginBtn setImage:[UIImage imageNamed:@"注销"] forState:(UIControlStateNormal)];
        
        if([user objectForKey:@"userNameLable"]){
            self.userNameLabel.text=[user objectForKey:@"userNameLable"];
        }
        else{
            self.userNameLabel.text=[user objectForKey:@"userName"];
        }
    }
    else{
        [self.loginBtn setImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateNormal)];
        self.userNameLabel.text=@"";
    }
}

- (IBAction)onLoginBtnTap:(id)sender {
    
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
    self.userNameLabel.text=@"";
    [user removeObjectForKey:@"userName"];
    [user setBool:NO forKey:@"login"];
    [self.loginBtn setImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateNormal)];
}
- (IBAction)onCollectionBtnTap:(id)sender {
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

}


@end

