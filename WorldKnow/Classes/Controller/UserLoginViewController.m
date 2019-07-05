//
//  UserLoginViewController.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "UserLoginViewController.h"
#import <AVOSCloud/AVUser.h>
//#import <UMSocialCore/UMSocialCore.h>
#import <UMShare/UMShare.h>

@interface UserLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackGround;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation UserLoginViewController

#pragma mark - Left Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.scrollEnabled = NO;
    if (@available(iOS 11.0, *)) {
        if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user boolForKey:@"login"]){
        self.textFieldUserName.text=[user objectForKey:@"userName"];
    }
    
}

#pragma mark - Methods
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}


#pragma mark - Action
- (IBAction)sinaLoginAction:(UIButton *)sender {
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    //
    //    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        //          获取微博用户名、uid、token等
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //
    //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
    //
    //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
    //            self.textFieldUserName.text=snsAccount.userName;
    //            self.textFieldPassword.text=snsAccount.usid;
    //            [self loginWithName:snsAccount.userName usid:snsAccount.usid token:snsAccount.accessToken];
    //
    //        }});
}

- (IBAction)loginAction:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"登录成功" preferredStyle: UIAlertControllerStyleAlert];
    
    //判断用户名和密码是否为空
    if(self.textFieldUserName.text.length!=0&&self.textFieldPassword.text.length!=0){
        //采用LeanClode把数据上传至服务器
        [AVUser logInWithUsernameInBackground:self.textFieldUserName.text password:self.textFieldPassword.text block:^(AVUser *user, NSError *error) {
            //判断user是否为空
            if (user != nil) {
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                    //沙盒中添加用户名,作为收藏数据的用户表的表名
                    [user setObject:self.textFieldUserName.text forKey:@"userName"];
                    //添加布尔类型,作为用户登录状态的标志
                    [user setBool:YES forKey:@"login"];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                alert.message=@"用户名或密码错误";
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.textFieldPassword.text=nil;
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    else{
        alert.message=@"用户名或密码为空";
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.textFieldUserName.text=nil;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    //    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)regAction:(id)sender {
    
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)QQLoginAction:(id)sender {
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    //
    //    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        //          获取微博用户名、uid、token等
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //
    //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
    //
    //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
    //            self.textFieldUserName.text=snsAccount.userName;
    //            self.textFieldPassword.text=snsAccount.usid;
    //            [self loginWithName:snsAccount.userName usid:snsAccount.usid token:snsAccount.accessToken];
    //        }});
}

- (void)loginWithName:(NSString *)userName usid:(NSString *)usid token:(NSString *)token{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"登录成功" preferredStyle: UIAlertControllerStyleAlert];
    //判断用户名和密码是否为空
    if(usid.length!=0&&token.length!=0){
        //采用LeanClode把数据上传至服务器
        [AVUser logInWithUsernameInBackground:usid password:token block:^(AVUser *user, NSError *error) {
            //判断user是否为空
            if (user != nil) {
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                    [user setObject:usid forKey:@"userName"];
                    [user setObject:userName forKey:@"userNameLable"];
                    [user setBool:YES forKey:@"login"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                AVUser *user = [AVUser user];
                user.username = usid;
                user.password = token;
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                            [user setObject:usid forKey:@"userName"];
                            [user setObject:userName forKey:@"userNameLable"];
                            [user setBool:YES forKey:@"login"];
                            [self dismissViewControllerAnimated:self completion:^{
                            }];
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    } else {
                        alert.message=@"登录失败";
                        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }];
            }
        }];
    }
    else{
        alert.message=@"第三方登录失败";
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.textFieldUserName.text=nil;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)keyboardWillShow:(id)sender{
    self.scrollView.scrollEnabled=YES;
}

- (void)keyboardWillHide:(id)sender{
    self.scrollView.scrollEnabled=NO;
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset=CGPointMake(0, 0);
    }];
}
@end

