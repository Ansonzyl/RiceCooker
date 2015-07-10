//
//  EnterPhoneNumberViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-8.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterPhoneNumberViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (nonatomic, copy) NSString *identityStr;
@property (weak, nonatomic) IBOutlet UIImageView *ohterImage;
@property (weak, nonatomic) IBOutlet UIButton *getBtutton;

- (IBAction)getPhoneNumber:(id)sender;
- (IBAction)tapback:(id)sender;

@end
