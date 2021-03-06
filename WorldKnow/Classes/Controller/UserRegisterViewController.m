//
//  UserRegisterViewController.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "UserRegisterViewController.h"

#import <AVOSCloud/AVUser.h>

@interface UserRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPasswordAgain;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    self.scrollView.scrollEnabled=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
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

#pragma mark - 注册事件
- (IBAction)RegAction:(id)sender {
    
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"注册成功" preferredStyle: UIAlertControllerStyleAlert];
    if(self.textFieldUserName.text.length!=0&&self.textFieldPassword.text.length!=0){
        
        
        if([self.textFieldPassword.text isEqualToString:self.textFieldPasswordAgain.text]){
            AVUser *user = [AVUser user];
            user.username = self.textFieldUserName.text;
            
            user.password = self.textFieldPassword.text;
            user.email =self.textFieldEmail.text;
            
            [user setObject:self.textFieldTel.text forKey:@"Tel"];
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        
                        [self dismissViewControllerAnimated:self completion:^{
                            
                        }];
                        
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    if(error.code==203){
                        alert.message=@"该邮箱已被注册";
                        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            self.textFieldPassword.text=nil;
                            self.textFieldPasswordAgain.text=nil;
                        }];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }
                    
                }
            }];
        }
        else{
            alert.message=@"密码不一致";
            
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.textFieldPassword.text=nil;
                self.textFieldPasswordAgain.text=nil;
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
    }
    else{
        alert.message=@"用户名或密码为空";
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.textFieldPassword.text=nil;
            self.textFieldPasswordAgain.text=nil;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    
    
    
}
#pragma mark - 返回事件
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}
@end
