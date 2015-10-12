//
//  ERiceChooseViewController.h
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_EVegetable.h"
#import "DeviceChangeDelegate.h"

@interface ERiceChooseViewController : UIViewController

@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, strong) NSString *currentButtonName;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) id <DeviceChangeDelegate> delegate;


- (IBAction)startCooking:(UIButton *)sender;

@end
