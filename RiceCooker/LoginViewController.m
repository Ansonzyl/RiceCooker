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
#import <sys/utsname.h>
@interface LoginViewController () <UITextFieldDelegate>
{
    BOOL isPassWord;
    BOOL isPhoneNumber;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    
//    if () {
//        _topCons.constant = 0;
//    }
    self.view.backgroundColor = UIColorFromRGB(0x40c8c4);
    self.phoneNumberTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.login_button.layer.cornerRadius = 2;
    _userDefaults  = [NSUserDefaults standardUserDefaults];
    self.passwordTextField.text = [_userDefaults objectForKey:@"password"];
    self.phoneNumberTextField.text = [_userDefaults objectForKey:@"phoneNumber"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)loginBtn:(id)sender {
    
//    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
//    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    
//    [self presentViewController:main animated:YES completion:nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_userDefaults setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
    [_userDefaults setObject:self.passwordTextField.text forKey:@"password"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"phonenumber":self.phoneNumberTextField.text, @"password":self.passwordTextField.text};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat: @"http://%@/LoginServlet", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([recieve isEqualToString:@"fail"]) {

            [self showTopMessage:@"用户名或密码错误"];

            
        }else if([recieve isEqualToString:@"success"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];

            [self presentViewController:main animated:YES completion:nil];
        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
                NSLog(@"%@", error);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录错误" message:@"无法连接到服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alertView show];
            [self showTopMessage:@"连接不到服务器"];

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
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.identityStr = identity;
//    [self presentViewController:navController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.phoneNumberTextField]) {
        self.phoneNumberImageView.highlighted = YES;
    }else if ([textField isEqual:self.passwordTextField])
    {
        self.passwordImageView.highlighted = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.phoneNumberImageView.highlighted = NO;
    self.passwordImageView.highlighted = NO;
}


- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}
@end
