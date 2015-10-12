//
//  LoiginViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *login_button;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

- (IBAction)loginBtn:(id)sender;

- (IBAction)registerBtn:(UIButton *)sender;
- (IBAction)fogetPasswordBtn:(UIButton *)sender;

- (IBAction)tapback:(id)sender;

@end
