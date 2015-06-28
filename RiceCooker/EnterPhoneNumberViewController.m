//
//  EnterPhoneNumberViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-8.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EnterPhoneNumberViewController.h"
#import "FogetPWViewController.h"
#import "RegisterViewController.h"
@interface EnterPhoneNumberViewController ()
@property (nonatomic, copy) NSString *urlStr;
@end

@implementation EnterPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.phoneImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"phone.png" ofType:nil]];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exit:)];
    self.navigationItem.leftBarButtonItem = button;
    if ([self.identityStr isEqualToString:@"注册"]) {
        self.title = self.identityStr;
        _urlStr = [NSString stringWithFormat:@"http://%@/RegisterPhonenumberServlet", SERVER_URL];
    }else if ([self.identityStr isEqualToString:@"忘记密码？"])
    {
        self.title = @"忘记密码";
        _urlStr = [NSString stringWithFormat:@"http://%@/ForgetPassword", SERVER_URL];
    }
    
}



- (void)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)getPhoneNumber:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    FogetPWViewController *viewController = [[FogetPWViewController alloc] initWithNibName:@"FogetPWViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
////    
    RegisterViewController *viewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    viewController.phoneNumber = self.phoneNumberTextField.text;
    [self.navigationController pushViewController:viewController animated:YES];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *paramters = @{@"phonenumber":self.phoneNumberTextField.text};
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:_urlStr parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        NSString *recive = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        if ([self.identityStr isEqualToString:@"忘记密码？"]) {
//            if ([recive isEqualToString:@"success"]) {
//                FogetPWViewController *viewController = [[FogetPWViewController alloc] initWithNibName:@"FogetPWViewController" bundle:nil];
//                viewController.phoneNumber = self.phoneNumberTextField.text;
//                [self.navigationController pushViewController:viewController animated:YES];
//                
//            }else
//            {
//                
//            }
//        }else if ([self.identityStr isEqualToString:@"注册"])
//        {
//            if ([recive isEqualToString:@"success"]) {
//                RegisterViewController *viewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//                 viewController.phoneNumber = self.phoneNumberTextField.text;
//                [self.navigationController pushViewController:viewController animated:YES];
//                
//            }else
//            {
//               
//            }
//
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//    }];
    
}

- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}
@end
