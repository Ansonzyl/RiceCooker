//
//  EnterPhoneNumberViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-8.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterPhoneNumberViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (nonatomic, copy) NSString *identityStr;
@property (strong, nonatomic) IBOutlet UIImageView *ohterImage;

- (IBAction)getPhoneNumber:(id)sender;
- (IBAction)tapback:(id)sender;

@end
