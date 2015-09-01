//
//  DevicesViewController.h
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevicesViewController : UIViewController
@property (nonatomic, strong) NSArray *devicesArray;
@property (nonatomic, assign) NSInteger currentNumber;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIButton *pNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *fireBtn;
@property (weak, nonatomic) IBOutlet UIButton *cookModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fireLabel;

@property (weak, nonatomic) IBOutlet UILabel *cookModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end
