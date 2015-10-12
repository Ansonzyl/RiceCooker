//
//  DevicesViewController.h
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceChangeDelegate.h"
#import "DM_EVegetable.h"


@interface DevicesViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *devicesArray;
@property (nonatomic, assign) NSInteger currentNumber;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic)  UIButton *pNumberBtn;
@property (strong, nonatomic)  UIButton *fireBtn;
@property (strong, nonatomic)  UIButton *cookModeBtn;
@property (strong, nonatomic)  UIButton *finishTimeBtn;
@property (strong, nonatomic)  UILabel *pNumberLabel;
@property (strong, nonatomic)  UILabel *fireLabel;

@property (strong, nonatomic)  UILabel *cookModeLabel;
@property (strong, nonatomic)  UILabel *finishTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)pushToNextView:(UIButton *)sender;

@property (nonatomic, weak) id <DeviceChangeDelegate> deviceDelegate;

@end
