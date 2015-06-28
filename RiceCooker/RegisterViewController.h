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

@property (strong, nonatomic) IBOutlet UIImageView *verificationCodeImage;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

@property (strong, nonatomic) IBOutlet UITextField *verificationTextField;

@property (strong, nonatomic) IBOutlet UIButton *verificationBtn;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIImageView *passwordImage;

@property (strong, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *nickNameImage;

- (IBAction)tapback:(id)sender;
- (IBAction)regain:(id)sender;

- (IBAction)uploadImage:(id)sender;

- (IBAction)upload:(id)sender;

@end
