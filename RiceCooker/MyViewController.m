//
//  MyViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyViewController.h"
#import "DashProgressView.h"
#import "DeviceChangeDelegate.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define rate [UIScreen mainScreen].bounds.size.width/414

@interface MyViewController () <UIAlertViewDelegate, DeviceChangeDelegate>
@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) DashProgressView *progressView;
@property (nonatomic, strong) UILabel *finishTimeLabel;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) UILabel *riceLabel;
@property (nonatomic, strong) UILabel *remainLabel;

@end

@implementation MyViewController



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
    
    _workingImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 284*rate, 304*rate)];
    _workingImage.center =  CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5 + 9);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"工作动画（%@）", _device.module] ofType:@".png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    self.workingImage.image = [UIImage imageWithData:imageData];
    
    [self.view addSubview:_workingImage];
    
    [self initializeButtons];
    
    [self setLabelWithRate];
    
    dispatch_async(queue, ^{
        if ([self timeOfInsulation]/60 > 5) {
#warning time
        }
    });
    
    
    
    dispatch_async(queue, ^{
        [self buttonWith:_device];
    });
    
}

- (void)changeDevice:(DM_EVegetable *)device withIndex:(NSInteger)index
{
    
}


- (void)setLabelWithRate
{
    CGRect frame = CGRectMake(0, 0, 100, 21);
    
    UIColor *textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.7];
    
    _remainLabel = [self setLabelWithFrame:frame withTextColor:textColor withText: @"剩余分钟数" withSize:12*rate];
    _remainLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5-40*rate);
    
    _finishTimeLabel = [self setLabelWithFrame:frame withTextColor:textColor withText: _device.appointTime withSize:12*rate];
    _finishTimeLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5+35*rate);
    
    _riceLabel = [self setLabelWithFrame:frame withTextColor:textColor withText:@"米仓还剩100%" withSize:12*rate];
    _riceLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5+55*rate);
    
    self.stateLabel = [self setLabelWithFrame:CGRectMake(0, 0, 120, 43) withTextColor:[UIColor whiteColor] withText:_device.module withSize:26*rate];
    _stateLabel.center = CGPointMake( kWidth * 0.5  ,kHeight * 0.71 * 0.5 - 5);
    
   

    [self.view addSubview:_stateLabel];
    [self.view addSubview:_remainLabel];
    [self.view addSubview:_finishTimeLabel];
    [self.view addSubview:_riceLabel];
    
    

}

- (void)initializeButtons
{
    CGFloat size = 51 *rate;
    CGFloat height = 415 *rate;
    _refrigerationBtn =  [self buttonWithFrame:CGRectMake (42*rate, height, size, size) WithImageName:@"icon-e菜宝-取消冷藏（152）"];
    _collectBtn = [self buttonWithFrame:CGRectMake(321*rate, height, size, size) WithImageName:@"icon-收藏(152)"];
    [_refrigerationBtn addTarget:self action:@selector(cancelreFrigerating:) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn addTarget:self action:@selector(collectingRecipe:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = CGRectMake(0, 0, 65 * rate, 21 * rate);
    size = 14 * rate;
    _collectionLabel = [self setLabelWithFrame:frame withText:@"收藏" withSize:size];
    _collectionLabel.center = [self makeCenterWithPoint:_collectBtn.center];
    
    _cancelreFrigerateLabel = [self setLabelWithFrame:frame withText:@"冷藏" withSize:size];
    _cancelreFrigerateLabel.center = [self makeCenterWithPoint:_refrigerationBtn.center];
    
    

    [self.view addSubview:_cancelreFrigerateLabel];
    [self.view addSubview:_collectionLabel];
    [self.view addSubview:_refrigerationBtn];
    [self.view addSubview:_collectBtn];
    
}

- (UILabel *)setLabelWithFrame:(CGRect)frame  withText:(NSString *)text withSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];
    
    label.textColor = [UIColor whiteColor];
    label.text = text;
    return label;
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 50*rate;
    return point;
}


- (UIButton *)buttonWithFrame:(CGRect)frame WithImageName:(NSString *)name
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    [button setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    return button;
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

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    // 计时器
    CGRect frame = CGRectMake(0, 0 , 244 * rate, 244 *rate);
    _progressView = [[DashProgressView alloc] initWithFrame:frame];
    _progressView.center = CGPointMake( kWidth * 0.5,kHeight * 0.71 * 0.5);

    if ([_device.module isEqualToString:@"烹饪中"]) {
        if (_device.remianTime > _device.settingTime) {
            _progressView.percent = 0;
        }else
        {
            _progressView.percent = (_device.settingTime - _device.remianTime) / _device.settingTime;
            _myTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        }

    }else
        _progressView.percent = 0;
    
    [self.view addSubview:_progressView];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_myTimer invalidate];
}

- (void)buttonWith:(DM_EVegetable *)device
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"工作动画（%@）", _device.module] ofType:@".png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    self.workingImage.image = [UIImage imageWithData:imageData];
    self.stateLabel.text = self.device.module;
    
    _refrigerationBtn.hidden = YES;
    _collectBtn.hidden = YES;
    _cancelreFrigerateLabel.hidden = YES;
    _collectionLabel.hidden = YES;
    
    if ([self.device.module isEqualToString:@"待机中"]) {
        _remainLabel.hidden = YES;
        _finishTimeLabel.hidden = YES;
        _stateLabel.text = _device.module;
        if ([self.device.device isEqualToString:@"e菜宝"]) {
            _riceLabel.hidden = YES;
        }
        
    }

    
    if ([device.module isEqualToString:@"烹饪中"]) {
        _stateLabel.text = [NSString stringWithFormat:@"%d", (int)device.remianTime/60];
         _riceLabel.hidden = YES;
        
    }
    
    
    if ([device.module isEqualToString:@"保温中"]) {
        if ([_device.device isEqualToString:@"e菜宝"]) {
            self.refrigerationBtn.hidden = NO;
            self.cancelreFrigerateLabel.hidden = NO;
            self.cancelreFrigerateLabel.text = @"启动冷藏";
        }
        _finishTimeLabel.text = @"已保温";
        _riceLabel.text = [NSString stringWithFormat:@"%d分钟", [self timeOfInsulation]];
        _riceLabel.font = [UIFont systemFontOfSize:15*rate];
                
    }else if ([device.module isEqualToString:@"冷藏中"])
    {
        _cancelreFrigerateLabel.text = @"取消冷藏";
        self.refrigerationBtn.hidden = NO;
        self.cancelreFrigerateLabel.hidden = NO;
        self.collectBtn.hidden = NO;
        self.collectionLabel.hidden = NO;
        _remainLabel.hidden = YES;
        _finishTimeLabel.hidden = YES;
        _riceLabel.hidden = YES;
    }

}

- (int)timeOfInsulation
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddHH:mm"];
    NSDate *finish = [formatter dateFromString:_device.finishtime];
    NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    int time = [now timeIntervalSinceDate:finish] / 60;
    return time;
}


- (void)countDown
{
    
    if (_device.remianTime <= 0) {
        [_myTimer invalidate];
        _device.remianTime = 0;
    }else
    {
        _device.remianTime -= 10;
        _device.remaintime = [NSString stringWithFormat:@"%d",(int)(_device.remianTime/60)];
        _progressView.percent = (_device.settingTime - _device.remianTime) / _device.settingTime;
        _stateLabel.text = _device.remaintime;
        
       
    }

}

- (IBAction)cancelreFrigerating:(id)sender {
    NSString *leftStr;
    NSString *rightStr;
    if ([_device.module isEqualToString:@"冷藏中"]) {
        rightStr = @"取消冷藏";
        leftStr = @"继续冷藏";
    }else
    {
        leftStr = @"继续保温";
        rightStr = @"启动冷藏";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认取消保温，启动冷藏" message:@"停止保温，转为冷藏状态" delegate:self cancelButtonTitle:nil otherButtonTitles:leftStr, rightStr, nil];
     [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self refrigerateNetwork];
        
    }
}

- (void)refrigerateNetwork
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"devicename":_device.devicename,
                                 @"uuid":_device.UUID};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([_device.module isEqualToString:@"保温中"]) {
        url = [NSString stringWithFormat:@"http://%@/StartFrezonServlet", SERVER_URL];
    }else if ([_device.module isEqualToString:@"冷藏中"]){
        url = [NSString stringWithFormat:@"http://%@/CancelFrezonServlet", SERVER_URL];
    }
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *recive = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", recive);
        if ([recive isEqualToString:@"success"]) {
            if ([_device.module isEqualToString:@"冷藏中"]) {
                _device.module = @"待机中";
            }else{
               _device.module = @"冷藏中";
            }

            
            [self buttonWith:_device];
            
            
        }else if ([recive isEqualToString:@"fail"])
        {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (IBAction)collectingRecipe:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://%@/CancelFrezonServlet", SERVER_URL];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *recive = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", recive);
        if ([recive isEqualToString:@"success"]) {
#warning 成功状态
            
        }else if ([recive isEqualToString:@"fail"])
        {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
