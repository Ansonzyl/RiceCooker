//
//  FogetPWViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "FogetPWViewController.h"

@interface FogetPWViewController ()<UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation FogetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    self.passwordTextField.delegate = self;
    self.verificationCodeTextField.delegate = self;
    self.repeatPWTextField.delegate = self;
    self.verificationCodeBtn.layer.cornerRadius = 2;
    self.upload_button.layer.cornerRadius = 2;
    
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
                [_verificationCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                _verificationCodeBtn.enabled = YES;
            });
        }else
        {
            NSString *timeStr = [NSString stringWithFormat:@"重获验证码(%d)",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verificationCodeBtn setTitle:timeStr forState:UIControlStateNormal];
                _verificationCodeBtn.enabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);

}


- (IBAction)regain:(id)sender {
    
    NSString *str = [NSString stringWithFormat:@"发送验证码到 %@", self.phoneNumber];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"修改号码",@"确认", nil];
    [alert show];

    
}



- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}



- (BOOL)checkUpload
{
    if (![self.passwordTextField.text isEqualToString:self.repeatPWTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }else if ([self.passwordTextField.text isEqualToString:@""] || [self.repeatPWTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码输入为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }else
        return YES;

}


- (IBAction)upload:(id)sender {
    if ([self checkUpload]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    _manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"edtextRandom":self.verificationCodeTextField.text,
                                @"edtextpassword":self.passwordTextField.text
                                };
    [_manager POST:[NSString stringWithFormat:@"http://%@/UpdatePassword", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1)
    {
        [self countDown];
        _manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
        [_manager POST:[NSString stringWithFormat:@"http://%@/ForgetPassword", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self countDown];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.verificationCodeTextField]) {
        self.verificationImageView.highlighted = YES;
    }else if ([textField isEqual:self.passwordTextField]){
        self.passwordImageView.highlighted = YES;
    }else if ([textField isEqual:self.repeatPWTextField])
    {
        self.repeatPWImage.highlighted = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.verificationCodeTextField.text isEqualToString:@""]) {
        self.verificationImageView.highlighted = NO;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        self.passwordImageView.highlighted = NO;
    }
    if ([self.repeatPWTextField.text isEqualToString:@""]) {
        self.repeatPWImage.highlighted = NO;
    }
    
}

@end
