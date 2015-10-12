//
//  UserInfoViewController.h
//  RiceCooker
//
//  Created by yi on 15/7/23.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UITableViewController
@property (nonatomic, copy) NSString *phoneNumber;
- (IBAction)bondDevices:(id)sender;

- (IBAction)shareDevices:(id)sender;
- (IBAction)collectRecipe:(id)sender;

@end
