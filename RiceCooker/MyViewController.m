//
//  MyViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyViewController.h"
#import "DashProgressView.h"

@interface MyViewController ()
@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, strong) UILabel *stateLabel;
@end

@implementation MyViewController

- (IBAction)cancelreFrigerating:(id)sender {
}

- (IBAction)collectingRecipe:(id)sender {
}

- (id)initWithDevice:(DM_EVegetable *)device
{
    if (self = [super initWithNibName:@"MyViewController" bundle:nil]) {
        _device = device;
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = _device.devicename;
    NSString *imageName = [NSString stringWithFormat:@"%@背景", _device.devicename];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *image = [NSData dataWithContentsOfFile:filePath];
    self.backgroundView.image = [UIImage imageWithData:image];
    CGRect frame = CGRectMake(0, 0 , 244, 244);
    DashProgressView *progressView = [[DashProgressView alloc] initWithFrame:frame];
    progressView.center = CGPointMake( self.backgroundView.frame.size.width * 0.5,self.backgroundView.frame.size.height * 0.5);
    progressView.percent = _device.remianTime/_device.settingTime;
    [self.view addSubview:progressView];
//    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"工作动画（%@）", _device.module] ofType:@".png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    self.workingImage.image = [UIImage imageWithData:imageData];
//    self.workingImage.image = [UIImage imageNamed:[NSString]];
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 43)];
    _stateLabel.center = CGPointMake( self.backgroundView.frame.size.width * 0.5,self.backgroundView.frame.size.height * 0.5);
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.text = _device.module;
    self.stateLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_stateLabel];
    _stateLabel.font = [UIFont systemFontOfSize:26];
    if ([_device.module isEqualToString:@"烹饪中"]) {
        _stateLabel.text = [NSString stringWithFormat:@"%d", (int)_device.remianTime/60];
        _stateLabel.font = [UIFont systemFontOfSize:43];
    }
    if ([_device.module isEqualToString:@"保温中"]) {
        
        self.refrigerationBtn.hidden = NO;
        self.cancelreFrigerateLabel.hidden = NO;
        self.cancelreFrigerateLabel.text = @"启动冷藏";
    }else if ([_device.module isEqualToString:@"冷藏中"])
    {
        self.refrigerationBtn.hidden = NO;
        self.cancelreFrigerateLabel.hidden = NO;
        self.collectBtn.hidden = NO;
        self.collectionLabel.hidden = NO;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
