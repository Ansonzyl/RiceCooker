//
//  RegisterViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = UIColorFromRGB(0x40c8c4);
//    self.passwordImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password.png" ofType:nil]];
//    self.nickNameImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"username.png" ofType:nil]];
//    self.verificationCodeImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"verification.png" ofType:nil]];
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width/2;
    self.iconImage.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self countDown];
}


- (void)countDown
{
    __block int timeout = 30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(nil, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verificationBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                _verificationBtn.enabled = YES;
            });
        }else
        {
            NSString *timeStr = [NSString stringWithFormat:@"重获验证码(%d)",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verificationBtn setTitle:timeStr forState:UIControlStateNormal];
                _verificationBtn.enabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
    
}



- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)regain:(id)sender {
    [self countDown];
}

- (IBAction)uploadImage:(id)sender {
    
    
    
}

- (IBAction)upload:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _manager =  [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramters = @{@"edtextRandom":self.verificationTextField.text, @"edtextpassword":self.passwordTextField.text, @"edtextsname":self.nickNameTextField.text};
    
    [_manager POST: [NSString stringWithFormat:@"http://%@/RegisterPasswordServlet", SERVER_URL]
 parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
     NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:YES];
     if ([recieve isEqualToString:@""]) {
         
     }else
     {
         
     }
     
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
 }];
    
}
@end
