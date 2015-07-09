//
//  LoiginViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *phoneNumberImageView;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UIButton *login_button;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (strong, nonatomic) IBOutlet UIImageView *otherLoginImage;

- (IBAction)loginBtn:(id)sender;

- (IBAction)registerBtn:(UIButton *)sender;
- (IBAction)fogetPasswordBtn:(UIButton *)sender;

- (IBAction)tapback:(id)sender;

@end
