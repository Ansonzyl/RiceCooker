//
//  LoiginViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "LoginViewController.h"
#import "EnterPhoneNumberViewController.h"
#import "MainViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.phoneNumberImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"phone.png" ofType:nil]];
    self.passwordImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password.png" ofType:nil]];
    self.otherLoginImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"else.png" ofType:nil]];
    _userDefaults  = [NSUserDefaults standardUserDefaults];
    self.passwordTextField.text = [_userDefaults objectForKey:@"password"];
    self.phoneNumberTextField.text = [_userDefaults objectForKey:@"phoneNumber"];
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




- (IBAction)loginBtn:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_userDefaults setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
    [_userDefaults setObject:self.passwordTextField.text forKey:@"password"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"phonenumber":self.phoneNumberTextField.text, @"password":self.passwordTextField.text};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat: @"http://%@/LoginServlet", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", recieve);
        
        if ([recieve isEqualToString:@"fail"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误" message:@"用户名或者密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

            
        }else if([recieve isEqualToString:@"success"])
        {
            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:main];
            [self presentViewController:main animated:YES completion:nil];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
                NSLog(@"%@", error);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误" message:@"无法连接到服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];

        }];

}

- (IBAction)registerBtn:(UIButton *)sender {
    
    [self presentView:sender.titleLabel.text];
}

- (IBAction)fogetPasswordBtn:(UIButton *)sender {
    [self presentView:sender.titleLabel.text];
}


- (void)presentView:(NSString *)identity
{
    EnterPhoneNumberViewController *viewController = [[EnterPhoneNumberViewController alloc] initWithNibName:@"EnterPhoneNumberViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.identityStr = identity;
    [self presentViewController:navController animated:YES completion:nil];
}



- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}
@end
