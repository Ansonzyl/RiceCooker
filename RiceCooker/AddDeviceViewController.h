//
//  AddDeviceViewController.h
//  RiceCooker
//
//  Created by yi on 15/7/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddDeviceViewController : UIViewController
@property (nonatomic, assign) BOOL isAdd;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *UUID;

@property (strong, nonatomic) IBOutlet UILabel *deviceLabel;

@end
