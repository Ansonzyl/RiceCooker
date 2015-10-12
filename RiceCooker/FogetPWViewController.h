//
//  FogetPWViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FogetPWViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *repeatPWTextField;
@property (strong, nonatomic) IBOutlet UIButton *verificationCodeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *verificationImageView;
@property (strong, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (strong, nonatomic) IBOutlet UIImageView *repeatPWImage;
@property (strong, nonatomic) IBOutlet UIButton *upload_button;

@property (nonatomic, copy) NSString *phoneNumber;

- (IBAction)regain:(id)sender;
- (IBAction)tapback:(id)sender;

- (IBAction)upload:(id)sender;

@end
