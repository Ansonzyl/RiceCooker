//
//  MyViewController.h
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_EVegetable.h"
#import "DashProgressView.h"
#import "DeviceChangeDelegate.h"
@interface MyViewController : UIViewController
@property (nonatomic, assign) NSInteger currntIndex;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (nonatomic, strong) DashProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIImageView *workingImage;
@property (nonatomic, strong) NSTimer *myTimer;
@property (strong, nonatomic) IBOutlet UIButton *collectBtn;
@property (strong, nonatomic) IBOutlet UIButton *refrigerationBtn;
@property (strong, nonatomic) IBOutlet UILabel *cancelreFrigerateLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectionLabel;
@property (nonatomic, weak) id<DeviceChangeDelegate>delegate;

- (IBAction)cancelreFrigerating:(id)sender;
- (IBAction)collectingRecipe:(id)sender;

- (id)initWithDevice:(DM_EVegetable *)device;


- (IBAction)back:(id)sender;


@end
