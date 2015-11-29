//
//  FogetPWViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "FogetPWViewController.h"
#import "MainViewController.h"
@interface FogetPWViewController ()<UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation FogetPWViewController
static int myTime;
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


//- (void)countDown
//{
//    __block int timeout = 30;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_source_set_timer(_timer, dispatch_walltime(nil, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if (timeout <= 0) {
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_verificationCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
//                _verificationCodeBtn.enabled = YES;
//            });
//        }else
//        {
//            NSString *timeStr = [NSString stringWithFormat:@"重获验证码(%d)",timeout];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_verificationCodeBtn setTitle:timeStr forState:UIControlStateNormal];
//                _verificationCodeBtn.enabled = NO;
//            });
//            timeout --;
//        }
//    });
//    dispatch_resume(_timer);
//
//}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:YES];
//    [_timer invalidate];
//}

#pragma mark CAPTCHA
- (void)changeButtonName
{
    if (myTime > 1) {
        self.verificationCodeBtn.enabled = NO;
        myTime --;
        NSString *string = [NSString stringWithFormat:@"重获验证码(%d)", myTime];
        [self.verificationCodeBtn setTitle:string forState:UIControlStateNormal];
        //        self.reGain.titleLabel.text = string;
    }else
    {
        [self.timer invalidate];
        self.verificationCodeBtn.enabled = YES;
        [self.verificationCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        //        self.reGain.titleLabel.text = @"重新获取验证码";
    }
}

- (void)countDown
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonName) userInfo:nil repeats:YES];
    self.verificationCodeBtn.enabled = NO;
    [self.verificationCodeBtn setTitle:@"重获验证码(30)" forState:UIControlStateNormal];
    
    myTime = 30;
    
}




- (IBAction)regain:(id)sender {
    
    NSString *str = [NSString stringWithFormat:@"发送验证码到 %@", self.phoneNumber];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"修改号码",@"确认", nil];
//    [alert show];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认手机号" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"修改号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self countDown];
        _manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
        [_manager POST:[NSString stringWithFormat:@"http://%@/ForgetPassword", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self countDown];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];

    }];
    [alert addAction:backAction];
    [alert addAction:goAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];


    
}



- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}



- (BOOL)checkUpload
{
    if (![self.passwordTextField.text isEqualToString:self.repeatPWTextField.text]) {
        [self showTopMessage:@"两次密码不一致"];
        return NO;
    }else if ([self.passwordTextField.text isEqualToString:@""] || [self.repeatPWTextField.text isEqualToString:@""]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码输入为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        [self showTopMessage:@"密码输入为空"];
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
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:YES];
        if ([recieve isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumber forKey:@"phoneNumber"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            
            [self presentViewController:main animated:YES completion:^{
                [_timer invalidate];
            }];
            
        }else{
            [self showTopMessage:@"重置失败，请重试"];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showTopMessage:@"连接不到服务器"];
    }];
    
}

//#pragma mark UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else if (buttonIndex == 1)
//    {
//            }
//}

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
