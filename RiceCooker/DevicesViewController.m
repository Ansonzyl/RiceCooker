//
//  DevicesViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DevicesViewController.h"
#import "MyViewController.h"

@interface DevicesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *viewControllers;
@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<_devicesArray.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.7)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * _devicesArray.count, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.delegate = self;
//    [self.view addSubview:_scrollView];
    
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
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}


- (void)gotoPage:(BOOL)animated
{
    NSUInteger page = self.pageControl.currentPage;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
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


@end
