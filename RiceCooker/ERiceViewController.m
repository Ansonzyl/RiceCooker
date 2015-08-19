//
//  ERiceViewController.m
//  RiceCooker
//
//  Created by yi on 15/6/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "ERiceViewController.h"
#define kOverViewHeight 400
#define kTempHeight 200

@interface ERiceViewController ()<UITableViewDataSource, UITableViewDelegate>\
{
    CGFloat vHeight;
    CGFloat vWidth;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *overView;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@end

@implementation ERiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    vWidth = self.view.frame.size.width;
    vHeight = self.view.frame.size.height;
    self.overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, vWidth, kOverViewHeight)];
    self.overView.backgroundColor = UIColorFromRGB(0x40C8C4);
    [self.view addSubview:_overView];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake (0, kOverViewHeight, vWidth, vHeight)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.startButton];
//    [self.view addSubview:_tableview];
//    _startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, vHeight-60, vWidth, 60)];
//    _startButton.backgroundColor = [UIColor redColor];
//    [_startButton setTitle:@"开始烹饪" forState:UIControlStateNormal];
//    [self.view addSubview:_startButton];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect aOriginRect = scrollView.frame;
    aOriginRect.origin.y = aOriginRect.origin.y - scrollView.contentOffset.y;
    
    if (aOriginRect.origin.y <= kOverViewHeight && aOriginRect.origin.y >= kTempHeight) {
        CGRect aOriginBounds = scrollView.bounds;
        aOriginBounds.origin = CGPointMake(0, 0);
        scrollView.bounds = aOriginBounds;
        
    }else if (aOriginRect.origin.y > kOverViewHeight)
    {
        aOriginRect.origin.y = kOverViewHeight;
    }else{
        aOriginRect.origin.y = kTempHeight;
    }
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    aOriginRect.size.height = screenSize.height - aOriginRect.origin.y -45;
    scrollView.frame = aOriginRect;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"hello world!";
    return cell;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
