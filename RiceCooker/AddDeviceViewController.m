//
//  AddDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "EasyLinkViewController.h"
#import "Reachability.h"
#import "ProgressView.h"

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
    _deviceTextField.text = [NSString stringWithFormat:@"发现%@", _device];
    if (_isAdd) {
        [self addDvice];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"barBack.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
}


- (void)addDvice
{
    _leftButton.hidden = YES;
    _rightButton.hidden = YES;
    _progress = [[ProgressView alloc] init];
    
    _progress.center = CGPointMake(self.view.center.x, self.view.frame.size.height *3/5);
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
    self.progress.percent += 0.2;
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
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com/"];
    NSLog(@"%ld", (long)[reach currentReachabilityStatus]);
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
        break;
    }
    if (reach.reachableOnWWAN)
    {
        isExistenceNetwork = YES;
    }
     return isExistenceNetwork;
}


- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)startStep:(id)sender {
    [self JSONWithURL];

}
@end
