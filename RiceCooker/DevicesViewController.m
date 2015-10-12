//
//  DevicesViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DevicesViewController.h"
#import "MyViewController.h"
#import "ERiceChooseViewController.h"

#import "DXPopover.h"
#import "AddDeviceCell.h"
#import "EVegetableChooseViewController.h"
#import "RiceGradViewController.h"
#import "DeviceChangeDelegate.h"
#define kCellHeight 58
#define kCellCount 8
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kRate [UIScreen mainScreen].bounds.size.width/414

@interface DevicesViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, DeviceChangeDelegate, UIAlertViewDelegate>
{
    CGFloat popoverWidth;
}
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
@property (nonatomic, strong) UITableView *moreTableView;
@property (nonatomic, strong) NSArray *moreArray;
@property (nonatomic, strong) UIImage *moreImage;
@property (nonatomic, strong) UIImage *cancelImage;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, copy) NSString *pNumberStr;
- (IBAction)startCook:(UIButton *)sender;

@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setButtonWithLabel];
    _device = _devicesArray[_currentNumber];
   
    [self setImageAndLabelWithDevice:_device];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
    [self myViewController];
    [self setPageView];
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"LabelContentList" ofType:@"plist"];
        _moreArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"deviceDetail"];


    dispatch_async(queue, ^{
               
        // popover
        
        UITableView *blueView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, kCellHeight * _moreArray.count) style:UITableViewStylePlain];
        blueView.dataSource = self;
        blueView.delegate = self;
        self.moreTableView = blueView;

    });
    
    
    dispatch_async(queue, ^{
        [self resetPopver];
    });
    
    dispatch_async(queue, ^{
        _pNumberBtn.tag = 0;
        _fireBtn.tag = 1;
        _cookModeBtn.tag = 2;
        _finishTimeBtn.tag = 3;

    });
    
}


// button label 位置
- (void)setButtonWithLabel
{
    double size = 51 * kRate;
    double height = 570 * kRate;
    _pNumberBtn = [[UIButton alloc] initWithFrame:CGRectMake(41*kRate, height, size, size)];
    _fireBtn = [[UIButton alloc] initWithFrame:CGRectMake(136*kRate, height, size, size)];
    _cookModeBtn = [[UIButton alloc] initWithFrame:CGRectMake(229*kRate, height, size, size)];
    _finishTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(322*kRate, height, size, size)];
    
    [_pNumberBtn addTarget:self action:@selector(pushToNextView:) forControlEvents:UIControlEventTouchUpInside];
    [_fireBtn addTarget:self action:@selector(pushToNextView:) forControlEvents:UIControlEventTouchUpInside];
    [_cookModeBtn addTarget:self action:@selector(pushToNextView:) forControlEvents:UIControlEventTouchUpInside];
    [_finishTimeBtn addTarget:self action:@selector(pushToNextView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGRect frame = CGRectMake(0, 0, 60*kRate, 21*kRate);
    
    _pNumberLabel = [self setLabelWithFrame:frame];
    _pNumberLabel.center = [self makeCenterWithPoint:_pNumberBtn.center];
    
    _fireLabel = [self setLabelWithFrame:frame];
    _fireLabel.center = [self makeCenterWithPoint:_fireBtn.center];
    
    _cookModeLabel = [self setLabelWithFrame:frame];
   _cookModeLabel.center = [self makeCenterWithPoint:_cookModeBtn.center];
    
   
    
    _finishTimeLabel = [self setLabelWithFrame:frame];
    _finishTimeLabel.center = [self makeCenterWithPoint:_finishTimeBtn.center];
    
    [self.view addSubview:_cookModeLabel];
    [self.view addSubview:_pNumberLabel];
    [self.view addSubview:_fireLabel];
    
    [self.view addSubview:_finishTimeLabel];
    
    [self.view addSubview:_cookModeBtn];
    [self.view addSubview:_fireBtn];
    [self.view addSubview:_pNumberBtn];
    [self.view addSubview:_finishTimeBtn];
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 50*kRate;
    return point;
}


- (void)myViewController
{
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<_devicesArray.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
}

- (UILabel *)setLabelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12 * kRate];
    
    label.textColor = [UIColor blackColor];
    return label;
}

- (void) setPageView
{
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize =
    CGSizeMake(kWidth * self.devicesArray.count, kHeight * 0.71);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;

    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    
    
    
    _pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, kHeight*0.71*0.94);
    _pageControl.numberOfPages = _devicesArray.count;
    
    [_pageControl addTarget:self action:@selector(gotoPage:) forControlEvents:UIControlEventValueChanged];
   
    _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xa6cce7);
    [self.view addSubview:_pageControl];
    
    
    
    if (_currentNumber >= 0) {
        [self loadScrollViewWithPage:_currentNumber + 1];
    }
    if (_currentNumber <= _devicesArray.count) {
        [self loadScrollViewWithPage:_currentNumber - 1];
    }
    [self loadScrollViewWithPage:_currentNumber];
    
    CGPoint pt = CGPointMake(kWidth * _currentNumber, 0);
    [_scrollView setContentOffset:pt];
    _pageControl.currentPage = _currentNumber;

}

- (void) setNavigationBar
{
    // navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xffffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xffffff) forKey:NSForegroundColorAttributeName]];
    
    // more
    _moreImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-更多.png" ofType:nil]];
    _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 31, 31)];
    [_moreButton setImage:_moreImage forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButtonItem= [[UIBarButtonItem alloc] initWithCustomView:_moreButton];
    self.navigationItem.rightBarButtonItem = _rightButtonItem;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.popover dismiss];
}

#pragma mark popover

- (void) resetPopver;
{
    self.popover = [DXPopover new];
    popoverWidth = kWidth;
}

- (IBAction)moreDetail:(id)sender
{
    if ([_moreButton.imageView.image isEqual:_moreImage]) {
        
        [self updateTableViewFrame];
        UIView *leftView = _rightButtonItem.customView;
        CGPoint startPoint = CGPointMake(CGRectGetMidX(self.moreButton.frame) , CGRectGetMinY(self.moreButton.frame) + 50);
        
        [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionDown withContentView:self.moreTableView inView:self.tabBarController.view];
        _cancelImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-关闭.png" ofType:nil]];
        [self.moreButton setImage:_cancelImage forState:UIControlStateNormal];
        self.title = @"更多";
        __weak typeof (self)weakSelf = self;
        self.popover.didDismissHandler = ^{
            [weakSelf bounceTargetView:leftView];
        };
        
    }else if([_moreButton.imageView.image isEqual:_cancelImage])
    {
        [self.popover dismiss];
    }

    
    
}
- (void)updateTableViewFrame
{
    CGRect tableViewFrame = self.moreTableView.frame;
    tableViewFrame.size.width = popoverWidth;
    self.moreTableView.frame = tableViewFrame;
}

- (void)bounceTargetView:(UIView *)targetView
{
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.5 delay:3 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        targetView.transform = CGAffineTransformIdentity;
        
        [_moreButton setImage:_moreImage forState:UIControlStateNormal];
        self.title = _titleName;
        
    } completion:nil];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _moreArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [AddDeviceCell ID];
    AddDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [AddDeviceCell AddDeviceCell];
    }
    cell.myLebel.text = _moreArray[indexPath.row];
    NSString *iamge = [NSString stringWithFormat:@"icon-%@.png", _moreArray[indexPath.row]];
    cell.logoImage.image = [UIImage imageNamed:iamge];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_moreArray[indexPath.row] isEqualToString:@"精米程度"]) {
        RiceGradViewController *viewController = [[RiceGradViewController alloc] initWithNibName:@"RiceGradViewController" bundle:nil];
        [self.popover dismiss];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}


#pragma mark 
- (void)setImageAndLabelWithDevice:(DM_EVegetable *)device
{
    _titleName = device.device;
    self.title = _titleName;
    
    if ([device.module isEqualToString:@"待机中"] || [device.module isEqualToString:@"冷藏中"]) {
        _startBtn.userInteractionEnabled = NO;
        if ([device.device isEqualToString:@"e饭宝"]) {
            
            [self.pNumberBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-米量（152）.png"] forState:UIControlStateNormal];
            [self.fireBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-烹饪方式（152）.png"] forState:UIControlStateNormal];
            [self.cookModeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-口感（152）.png"] forState:UIControlStateNormal];
        }else if([device.device isEqualToString:@"e菜宝"])
        {
            [self.pNumberBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝烹饪方式（152）.png"] forState:UIControlStateNormal];
            [self.fireBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝食材（152）.png"] forState:UIControlStateNormal];
            [self.cookModeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝重量（152）.png"] forState:UIControlStateNormal];
        }
        [self.finishTimeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-预约（152）.png"] forState:UIControlStateNormal];
        self.pNumberBtn.enabled = YES;
        self.fireBtn.enabled = YES;
        self.cookModeBtn.enabled = YES;
        self.finishTimeBtn.enabled = YES;
        [self.startBtn setTitle:@"开始烹饪" forState:UIControlStateNormal];
        self.startBtn.userInteractionEnabled = NO;
    }else
    {
        self.startBtn.userInteractionEnabled = YES;
        if ([device.device isEqualToString:@"e饭宝"]) {
            
            [self.pNumberBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-米量不可选（152）.png"] forState:UIControlStateNormal];
            [self.fireBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-烹饪方式不可选（152）.png"] forState:UIControlStateNormal];
            [self.cookModeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-口感不可选（152）.png"] forState:UIControlStateNormal];
        }else if([device.device isEqualToString:@"e菜宝"])
        {
            [self.pNumberBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝-烹饪方式不可选（152）.png"] forState:UIControlStateNormal];
            [self.fireBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝-食材不可选（152）.png"] forState:UIControlStateNormal];
            [self.cookModeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e菜宝-重量不可选（152）.png"] forState:UIControlStateNormal];
        }
        [self.finishTimeBtn setBackgroundImage:[UIImage imageNamed:@"icon-e饭宝-预约不可选（152）.png"] forState:UIControlStateNormal];
        self.pNumberBtn.enabled = NO;
        self.fireBtn.enabled = NO;
        self.cookModeBtn.enabled = NO;
        self.finishTimeBtn.enabled = NO;
        if ([device.module isEqualToString:@"保温中"]) {
            [self.startBtn setTitle:@"取消保温" forState:UIControlStateNormal];
        }else
            [self.startBtn setTitle:@"取消烹饪" forState:UIControlStateNormal];
        

    }

 
    if ([_device.device isEqualToString:@"e饭宝"]) {
        self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份",device.pnumberweight];
        self.cookModeLabel.text = device.state;
        self.fireLabel.text = device.degree;
    }else
    {
        self.pNumberLabel.text = device.degree;
        self.cookModeLabel.text = device.pnumberweight;
        self.fireLabel.text = device.state;

    }
    
    self.finishTimeLabel.text = device.appointTime;
//    if ([_device.module isEqualToString:@"开始烹饪"]) {
//        _startBtn.userInteractionEnabled = NO;
//    }else
//        _startBtn.userInteractionEnabled = YES;
    
}






- (void)loadScrollViewWithPage:(NSInteger)page
{
    if (page >= _devicesArray.count) {
        return;
    }
    MyViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[MyViewController alloc] initWithDevice:_devicesArray[page]];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
        
    }
    if (controller.view.superview == nil) {
        CGRect frame = self.view.frame;
        frame.origin.x = kWidth * page;
        frame.origin.y = 0;

        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        controller.currntIndex = page;
        
        
    }
    
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
        NSUInteger numPages = self.devicesArray.count;
        self.scrollView.contentSize = CGSizeMake(kWidth * numPages, kHeight * 0.71);
        self.viewControllers = nil;
        NSMutableArray *controllers = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < _devicesArray.count; i++) {
            [controllers addObject:[NSNull null]];
        }
    self.viewControllers = controllers;
    [self scrollWithPage:self.pageControl.currentPage];
    [self gotoPage:NO];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    _device = _devicesArray[page];
    [self setImageAndLabelWithDevice:_device];
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self scrollWithPage:page];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}


- (void)scrollWithPage:(NSInteger)page
{
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}


- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    
    [self scrollWithPage:page];
    
    // update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
    
}

- (IBAction)changePage:(id)sender {
    [self gotoPage:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  devieDelegate
- (void)changeDevice:(DM_EVegetable *)device withIndex:(NSInteger)index
{
    [_devicesArray replaceObjectAtIndex:index withObject:device];
    [self setImageAndLabelWithDevice:device];
    [self myViewController];
    [self scrollWithPage:index];
    
}


- (IBAction)pushToNextView:(UIButton *)sender {
    if ([_device.device isEqualToString:@"e饭宝"]) {
        ERiceChooseViewController *viewController = [[ERiceChooseViewController alloc] initWithNibName:@"ERiceChooseViewController" bundle:nil];
        viewController.currentButtonName = sender.currentTitle;
        viewController.currentTag = sender.tag;
        viewController.device = self.device;
        viewController.currentIndex = self.pageControl.currentPage;
        viewController.delegate = self;
        [self.navigationController pushViewController:viewController animated:YES];
    }else
    {
        EVegetableChooseViewController *viewController = [[EVegetableChooseViewController alloc] initWithNibName:@"EVegetableChooseViewController" bundle:nil];
        viewController.device = self.device;
        viewController.currentButtonName = sender.currentTitle;
        viewController.currentTag = sender.tag;
        viewController.currentIndex = self.pageControl.currentPage;
        viewController.delegate = self;

        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}
- (IBAction)startCook:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"取消烹饪"] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认取消烹饪" message:@"停止烹饪锅内食物，转为待机状态" delegate:self cancelButtonTitle:nil otherButtonTitles:@"继续烹饪", @"结束烹饪", nil];
        [alert show];
        
        
    }else if ( [sender.titleLabel.text isEqualToString:@"取消保温"])
    {
        
    }else
    {
        _device.module = @"烹饪中";
    }
    
    [self changeDevice:_device withIndex:_pageControl.currentPage];
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        if ([_device.module isEqualToString:@"烹饪中"])
        {
            [self cancelCookingWithState:@"取消烹饪"];
        }else if ([_device.module isEqualToString:@"保温中"])
        {
            [self cancelCookingWithState:@"取消保温"];
        }
        
    }
}



- (void)cancelCookingWithState:(NSString *)module
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters;
    if ([_device.module isEqualToString:@"e饭宝"]) {
        parameters = @{@"phonenumber":_device.phonenumber,
                         @"device":_device.device,
                         @"pnumberweight":_device.pnumberweight,
                         @"degree":_device.degree,
                         @"state":_device.state,
                         @"devicename":_device.devicename,
                         @"finishtime":_device.finishtime,
                         @"UUID":_device.UUID,
                         @"module":module};
    }else
    {
        parameters = @{@"phonenumber":_device.phonenumber,
                       @"device":_device.device,
                       @"pnumberweight":[NSString stringWithFormat:@"%d", [_device.pnumberweight intValue]],
                       @"degree":_device.degree,
                       @"state":_device.state,
                       @"devicename":_device.devicename,
                       @"finishtime":_device.finishtime,
                       @"UUID":_device.UUID,
                       @"module":module,
                       @"settime":[NSString stringWithFormat:@"%f", _device.settingTime]};

    }


    
    [manager POST:[NSString stringWithFormat: @"http://%@/CancelsoakcookServlet", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", recieve);
        if ([recieve isEqualToString:@"cancel"]) {
            _device.module = @"待机中";
            [_deviceDelegate changeDevice:_device withIndex:_pageControl.currentPage];
            
            [self changeDevice:_device withIndex:_pageControl.currentPage];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    }];
}


@end
