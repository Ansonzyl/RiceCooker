//
//  MyViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyViewController.h"
#import "DashProgressView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString *imageName = [NSString stringWithFormat:@"%@背景", _device.devicename];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *image = [NSData dataWithContentsOfFile:filePath];
    self.backgroundView.image = [UIImage imageWithData:image];
    double rate = kWidth/414;
    
    CGRect frame = CGRectMake(0, 0 , 244 * rate, 244 *rate);
    DashProgressView *progressView = [[DashProgressView alloc] initWithFrame:frame];
    progressView.center = CGPointMake( kWidth * 0.5,kHeight * 0.71 * 0.5);
    if (_device.remianTime > _device.settingTime) {
        progressView.percent = 0;
    }else
    {
        progressView.percent = (_device.settingTime - _device.remianTime) / _device.settingTime;
    }
    [self.view addSubview:progressView];
    
    _workingImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 284*rate, 304*rate)];
    _workingImage.center =  CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5 + 9);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"工作动画（%@）", _device.module] ofType:@".png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    self.workingImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:_workingImage];

    
    [self setLabelWithRate:rate];
    
    
    dispatch_async(queue, ^{
        [self buttonWith:_device];
    });
    
}

- (void)setLabelWithRate:(double)rate
{
    CGRect frame = CGRectMake(0, 0, 100, 21);
    
    UIColor *textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.7];
    UILabel *stateLabel = [self setLabelWithFrame:frame withTextColor:textColor withText: @"剩余分钟数" withSize:12*rate];
    stateLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5-40*rate);
    
    UILabel *finishTimeLabel = [self setLabelWithFrame:frame withTextColor:textColor withText: _device.appointTime withSize:12*rate];
    finishTimeLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5+35*rate);
    
    UILabel *riceLabel = [self setLabelWithFrame:frame withTextColor:textColor withText:@"米仓还剩100%" withSize:12*rate];
    riceLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5+55*rate);
    
    self.stateLabel = [self setLabelWithFrame:CGRectMake(0, 0, 120, 43) withTextColor:[UIColor whiteColor] withText:_device.module withSize:26*rate];
    _stateLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5 - 5);
    

    [self.view addSubview:_stateLabel];
    [self.view addSubview:stateLabel];
    [self.view addSubview:finishTimeLabel];
    [self.view addSubview:riceLabel];
    
    
    if ([self.device.module isEqualToString:@"待机中"]) {
        stateLabel.hidden = YES;
         finishTimeLabel.hidden = YES;
        
        if ([self.device.device isEqualToString:@"e菜宝"]) {
            riceLabel.hidden = YES;
        }

    }else if ([self.device.module isEqualToString:@"烹饪中"])
    {
        riceLabel.hidden = YES;
    }

}

- (UILabel *)setLabelWithFrame:(CGRect)frame withTextColor:(UIColor *)color withText:(NSString *)text withSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];;
    
    label.textColor = color;
    label.text = text;
    return label;
}


- (void)buttonWith:(DM_EVegetable *)device
{
    if ([device.module isEqualToString:@"烹饪中"]) {
        _stateLabel.text = [NSString stringWithFormat:@"%d", (int)device.remianTime/60];
        _stateLabel.font = [UIFont systemFontOfSize:43];
    }
    
    if ([device.module isEqualToString:@"保温中"]) {
        self.refrigerationBtn.hidden = NO;
        self.cancelreFrigerateLabel.hidden = NO;
        self.cancelreFrigerateLabel.text = @"启动冷藏";
        
    }else if ([device.module isEqualToString:@"冷藏中"])
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
