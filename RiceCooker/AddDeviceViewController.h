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
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *phoneNumber;
@end
