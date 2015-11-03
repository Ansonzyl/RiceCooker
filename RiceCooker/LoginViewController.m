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
#import "DM_UIConten.h"
#define kRate [UIScreen mainScreen].bounds.size.width/414

@interface LoginViewController () <UITextFieldDelegate>
{
    BOOL isPassWord;
    BOOL isPhoneNumber;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) DM_UIConten *ui;
//@property (nonatomic, strong) UIControl *control;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    _ui = [[DM_UIConten alloc] init];
    [self setLabelAndImageAndButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"barBack.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
    self.view.backgroundColor = UIColorFromRGB(0x40c8c4);
    
//    [_control addTarget:self.view action:@selector(tapback:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:_control];
    
    self.phoneNumberTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    _userDefaults  = [NSUserDefaults standardUserDefaults];
    self.passwordTextField.text = [_userDefaults objectForKey:@"password"];
    self.phoneNumberTextField.text = [_userDefaults objectForKey:@"phoneNumber"];
    if (!([self.phoneNumberTextField isEqual:nil]||[self.phoneNumberTextField.text isEqualToString:@""])) {
        self.phoneNumberImageView.highlighted = YES;
    }
    if (![self.passwordTextField.text isEqualToString:@""]) {
        self.passwordImageView.highlighted = YES;
    }

    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (UIButton *)initializeButtonWithFrame:(CGRect)frame withText:(NSString *)text withColor



- (void)setLabelAndImageAndButton
{
    
    CGRect frame = CGRectMake(0, 0, 385*kRate, 57*kRate);
    
    
    
    _logoImageView = [_ui initializeImageWithFrame:CGRectMake(181*kRate, 21*kRate, 51*kRate, 65*kRate) withImageName:@"logo-dicooker" withHightlightImage:nil];
    _phoneNumberImageView = [_ui initializeImageWithFrame:CGRectMake(15*kRate, 123*kRate, 385*kRate, 57*kRate) withImageName:@"phone" withHightlightImage:@"phone输入后"];
    _passwordImageView = [_ui initializeImageWithFrame:frame withImageName:@"password" withHightlightImage:@"password输入后"];
    
    _passwordImageView.center = [self makeCenterWithPoint:_phoneNumberImageView.center wihtHeight:71];
    
    UIButton *loginBton = [_ui setButtonWithFrame:frame   withText:@"登 录" withFont:19];
    [loginBton addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    loginBton.center = [self makeCenterWithPoint:_passwordImageView.center wihtHeight:71];
    loginBton.layer.cornerRadius = 4;
    loginBton.backgroundColor = UIColorFromRGB(0x2bb0ac);
    
    _phoneNumberTextField = [_ui initializeTextFieldWithFrame:CGRectMake(60*kRate, 137*kRate, 213*kRate, 30*kRate) withFont:14 withtextAlignment:NSTextAlignmentLeft withPlaceholderText:@"手机号" withColor:[UIColor whiteColor]];
    
    _passwordTextField = [_ui initializeTextFieldWithFrame:CGRectMake(60*kRate, 208*kRate, 213*kRate, 30*kRate) withFont:14 withtextAlignment:NSTextAlignmentLeft withPlaceholderText:@"密码" withColor:[UIColor whiteColor]];
    _passwordTextField.secureTextEntry = YES;
    UIButton *regist = [_ui setButtonWithFrame:CGRectMake(15*kRate, 330*kRate, 30*kRate, 30*kRate)  withText:@"注册" withFont:15];
        [regist addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *forgetPassWord = [_ui setButtonWithFrame:CGRectMake(321*kRate, 330*kRate, 79*kRate, 30*kRate)  withText:@"忘记密码？" withFont:15];
        [forgetPassWord addTarget:self action:@selector(fogetPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *other = [_ui initializeImageWithFrame:CGRectMake(0, 0, 386*kRate, 94*kRate) withImageName:@"other" withHightlightImage:nil];
    other.center = [self makeCenterWithPoint:_passwordImageView.center wihtHeight:190];
    
    [self.view addSubview:forgetPassWord];
    [self.view addSubview:other];
    [self.view addSubview:regist];
    [self.view addSubview:_passwordImageView];
    [self.view addSubview:_phoneNumberImageView];
    [self.view addSubview:loginBton];
    [self.view addSubview:_logoImageView];
    
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_phoneNumberTextField];
    
    
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center wihtHeight:(CGFloat)height
{
    CGPoint point = center;
    point.y += height*kRate;
    return point;
}


- (IBAction)loginBtn:(id)sender {
   
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    if (!(self.phoneNumberTextField.text == nil || self.passwordTextField.text == nil)) {
//        [_userDefaults setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
//        [_userDefaults setObject:self.passwordTextField.text forKey:@"password"];
//    }
//    
//    
//    NSString *urlStr = [NSString stringWithFormat: @"http://%@/LoginServlet", SERVER_URL];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];
//
//    NSString *body = [NSString stringWithFormat:@"phonenumber=%@&password=%@", self.phoneNumberTextField.text, self.passwordTextField.text];
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        NSString *recieve = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        if ([recieve isEqualToString:@"fail"]) {
//            
//            [self showTopMessage:@"用户名或密码错误"];
//            
//            
//        }else if([recieve isEqualToString:@"success"])
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
//            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//            
//            [self presentViewController:main animated:YES completion:nil];
//        }
//        NSLog(@"%@",error);
//
//        
//    }];
//    
//    [task resume];

    
    
    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *paramters = @{@"phonenumber":self.phoneNumberTextField.text, @"password":self.passwordTextField.text};
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *url = [NSString stringWithFormat: @"http://%@/LoginServlet", SERVER_URL];
//    [manager POST:url parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        if ([recieve isEqualToString:@"fail"]) {
//
//            [self showTopMessage:@"用户名或密码错误"];
//
//            
//        }else if([recieve isEqualToString:@"success"])
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *main = [stroyboard instantiateViewControllerWithIdentifier:@"MainViewController"];

            [self presentViewController:main animated:YES completion:nil];
//        }
//        
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//                NSLog(@"%@", error);
//                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            [self showTopMessage:@"连接不到服务器"];
//
//        }];
//
    

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
    if ([self.phoneNumberTextField isEqual:nil]||[self.phoneNumberTextField.text isEqualToString:@""]) {
        self.phoneNumberImageView.highlighted = NO;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
         self.passwordImageView.highlighted = NO;
    }
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)registerBtn:(UIButton *)sender
{
    [self presentView:@"注册"];
}


- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}
@end
