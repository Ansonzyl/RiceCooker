//
//  AddDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "EasyLinkViewController.h"

#import "ProgressView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kRate [UIScreen mainScreen].bounds.size.width/414

@interface AddDeviceViewController ()
- (IBAction)exit:(id)sender;
@property (nonatomic, copy) NSString *state;
- (IBAction)startStep:(id)sender;
@property (nonatomic, strong) ProgressView *progress;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加设备";
    [self initializeLabelAndButton];
    _deviceLabel.text = [NSString stringWithFormat:@"发现%@", _device];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"barBack.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    
//    if (_isAdd) {
//        [self addDvice];
//    }
    if (_isAdd) {
        _leftButton.hidden = YES;
        _rightButton.hidden = YES;
        _startButton.hidden = NO;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   }

- (void)initializeLabelAndButton
{
    
    _deviceLabel = [self setLabelWithFrame:CGRectMake(0, 80*kRate, kWidth, 21*kRate) withSize:19 withText:nil];
    
    UILabel *label = [self setLabelWithFrame:CGRectMake(0, 102*kRate, kWidth, 21*kRate) withSize:12 withText:@"请检查指示灯是否在慢闪状态"];
    
    _leftButton = [self setButtonWithFrame:CGRectMake(14*kRate, 418*kRate, 192*kRate, 57*kRate) WithImage:@"左半按钮" withAction:nil withText:@"否"];
    _rightButton = [self setButtonWithFrame:CGRectMake(207 * kRate, 418*kRate, 192*kRate, 57*kRate) WithImage:@"右半按钮" withAction:@selector(PushEasyLink:) withText:@"是"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(137*kRate, 150*kRate, 140*kRate, 208*kRate)];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pic-e饭宝" ofType:@"png"]];
    _startButton = [self setButtonWithFrame:CGRectMake(15*kRate, 418*kRate, 385*kRate, 57*kRate) WithImage:nil withAction:@selector(startStep:) withText:@"开始体验"];
    _startButton.hidden = YES;
    [_startButton setBackgroundImage:nil forState:UIControlStateNormal];
    _startButton.backgroundColor = UIColorFromRGB(0x2bb0ac);
    _startButton.layer.cornerRadius = 2;
    
    [self.view addSubview:_startButton];
    [self.view addSubview:imageView];
    [self.view addSubview:_leftButton];
    [self.view addSubview:_rightButton];
    [self.view addSubview:label];
    [self.view addSubview:_deviceLabel];
    
    
    
}

- (UIButton *)setButtonWithFrame:(CGRect)frame WithImage:(NSString *)imageName withAction:(SEL)action withText:(NSString *)text
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    [button setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:18*kRate];
    
    return  button;
    
}

- (UILabel *)setLabelWithFrame:(CGRect)frame withSize:(CGFloat)size withText:(NSString*)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size * kRate];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    return label;
}



- (void)addDvice
{
    _leftButton.hidden = YES;
    _rightButton.hidden = YES;
    _startButton.hidden = NO;
    _progress = [[ProgressView alloc] init];
    
    _progress.center = CGPointMake(kWidth / 2, kHeight *4/5);
    _progress.bounds = CGRectMake(0, 0, 62, 62);
    _progress.arcUnfinishColor = UIColorFromRGB(0xffffff);
    _progress.arcFinishColor = UIColorFromRGB(0xffffff);
    _progress.arcBackColor = UIColorFromRGB(0xa0e4e2);
    _progress.percent = 0;
    _progress.centerColor = UIColorFromRGB(0x40c8c4);
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downLoad) userInfo:nil repeats:YES];
    [self.view addSubview:_progress];

}



- (void)downLoad{
    self.progress.percent += 0.125;
    if (self.progress.percent == 1) {
        [_myTimer invalidate];
        _progress.hidden = YES;
        if ([self isConnectionAvailable]){
            self.startButton.hidden = NO;
        }else
        {
            
            [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
            [_rightButton setTitle:@"重试" forState:UIControlStateNormal];
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
        }
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_myTimer invalidate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PushEasyLink:(id)sender {
    if (_isAdd) {
        [self addDvice];
    }else
    {
    EasyLinkViewController *viewController = [[EasyLinkViewController alloc] initWithNibName:@"EasyLinkViewController" bundle:nil];
        viewController.UUID = self.UUID;
        viewController.device = self.device;
    [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)JSONWithURL
{
    
    
    NSString *urlStr = [NSString stringWithFormat: @"http://%@/StartexPerienceServlet", SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"device":self.device,
                                @"phonenumber": _phoneNumber,
                                @"uuid" : self.UUID};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *recive = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", recive);
        
        if ([recive isEqualToString:@"success"])
        {
            NSLog(@"success");
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
            
        }else if ([recive isEqualToString: @"fail"]) {

            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
       
    }];

}

-(BOOL) isConnectionAvailable{
#warning 需要重写
    
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com/"];
//    NSLog(@"%ld", (long)[reach currentReachabilityStatus]);
//    switch ([reach currentReachabilityStatus])
//    {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            //NSLog(@"notReachable");
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            //NSLog(@"WIFI");
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            //NSLog(@"3G");
//        break;
//    }
//    if (reach.reachableOnWWAN)
//    {
//        isExistenceNetwork = YES;
//    }
//     return isExistenceNetwork;
    return YES;
}


- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)startStep:(id)sender {
    
    [self JSONWithURL];

}
@end
