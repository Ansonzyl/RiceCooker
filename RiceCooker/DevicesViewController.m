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
#import "DM_EVegetable.h"
#import "DXPopover.h"
#import "AddDeviceCell.h"
#import "EVegetableChooseViewController.h"

#define kCellHeight 58
#define kCellCount 7

@interface DevicesViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
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

@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];

    _device = _devicesArray[_currentNumber];
    [self setImageAndLabelWithDevice:_device];
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<_devicesArray.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.7)];
    
    // a page is the width of the scroll view
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.devicesArray.count, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.center = CGPointMake(CGRectGetWidth(self.scrollView.frame)*0.5, CGRectGetHeight(self.scrollView.frame)*0.94);
    _pageControl.bounds = CGRectMake(0, 0, 150, 50);
    
    _pageControl.numberOfPages = _devicesArray.count;
    [_pageControl addTarget:self action:@selector(gotoPage:) forControlEvents:UIControlEventValueChanged];
//    _pageControl.currentPageIndicatorTintColor = []
    _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xa6cce7);
    [self.view addSubview:_pageControl];
    
    
    
    if (_currentNumber >= 0) {
        [self loadScrollViewWithPage:_currentNumber + 1];
    }
    if (_currentNumber <= _devicesArray.count) {
        [self loadScrollViewWithPage:_currentNumber - 1];
    }
    [self loadScrollViewWithPage:_currentNumber];
    
    CGPoint pt = CGPointMake(CGRectGetWidth(self.scrollView.frame)*_currentNumber, 0);
    [_scrollView setContentOffset:pt];
    _pageControl.currentPage = _currentNumber;
    
 
    
    
    // popover
    
    UITableView *blueView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, kCellHeight*kCellCount) style:UITableViewStylePlain];
    blueView.dataSource = self;
    blueView.delegate = self;
    self.moreTableView = blueView;
    
    _moreArray = [NSArray arrayWithObjects:@"修改设备名称", @"分享给家人", @"米仓信息", @"检查固件升级", @"解除连接", @"反馈", @"说明书", nil];
    [self resetPopver];
    
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



#pragma mark popover

- (void) resetPopver;
{
    self.popover = [DXPopover new];
    popoverWidth = CGRectGetWidth(self.view.bounds);
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
    return cell;
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}



#pragma mark 
- (void)setImageAndLabelWithDevice:(DM_EVegetable *)device
{
    _titleName = device.device;
    self.title = _titleName;
    if ([device.module isEqualToString:@"关机中"] || [device.module isEqualToString:@"冷藏中"]) {
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
    }else
    {
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
    
    self.pNumberLabel.text = device.pnumberweight;
    self.fireLabel.text = device.state;
    self.cookModeLabel.text = device.degree;
    self.finishTimeLabel.text = device.finishtime;
    
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
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        
    }
    
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
        NSUInteger numPages = self.devicesArray.count;
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numPages, CGRectGetHeight(self.scrollView.frame));
        self.viewControllers = nil;
        NSMutableArray *controllers = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < _devicesArray.count; i++) {
            [controllers addObject:[NSNull null]];
        }
    self.viewControllers = controllers;
    [self loadScrollViewWithPage:self.pageControl.currentPage - 1];
    [self loadScrollViewWithPage:self.pageControl.currentPage];
    [self loadScrollViewWithPage:self.pageControl.currentPage + 1];
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
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}


- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
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


- (IBAction)pushToNextView:(UIButton *)sender {
    if ([_device.device isEqualToString:@"e饭宝"]) {
        ERiceChooseViewController *viewController = [[ERiceChooseViewController alloc] initWithNibName:@"ERiceChooseViewController" bundle:nil];
        viewController.currentButtonName = sender.currentTitle;
        viewController.currentTag = sender.tag;
        viewController.device = self.device;
        [self.navigationController pushViewController:viewController animated:YES];
    }else
    {
        EVegetableChooseViewController *viewController = [[EVegetableChooseViewController alloc] initWithNibName:@"EVegetableChooseViewController" bundle:nil];
        viewController.device = self.device;
        viewController.currentButtonName = sender.currentTitle;
        viewController.currentTag = sender.tag;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}
@end
