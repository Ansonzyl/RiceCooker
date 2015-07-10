//
//  RegisterViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (nonatomic, copy) NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *verificationCodeImage;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;

@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImage;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *nickNameImage;
@property (weak, nonatomic) IBOutlet UIButton *register_button;

- (IBAction)tapback:(id)sender;
- (IBAction)regain:(id)sender;

- (IBAction)uploadImage:(id)sender;

- (IBAction)upload:(id)sender;

@end
