//
//  MyKitchenViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyKitchenViewController.h"
#import "AddDeviceViewController.h"
#import "DXPopover.h"
#define TYPE 2

@interface MyKitchenViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat popoverWidth;
}
@property (nonatomic, strong) NSArray *recieveArray;
@property (nonatomic, strong) NSArray *riceArray;
@property (nonatomic, strong) NSArray *vegetableArray;
@property (nonatomic, strong) UIBarButtonItem *addBuuton;
@property (nonatomic, strong) UITableView *addTableView;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) NSArray *config;
@end

@implementation MyKitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的厨房";
    _addBuuton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDevice:)];
    self.navigationItem.rightBarButtonItem = _addBuuton;
    UITableView *blueView = [[UITableView alloc] init];
    blueView.frame = CGRectMake(0, 0, popoverWidth, self.view.frame.size.height * 4/5);
    blueView.dataSource = self;
    blueView.delegate = self;
    self.addTableView = blueView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self resetPopover];
    _config = [NSArray arrayWithObjects:@"e饭煲", @"e菜煲", nil];
    _phoneNumber = @"13588238068";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetPopover
{
    self.popover = [DXPopover new];
    popoverWidth = CGRectGetWidth(self.view.bounds);
}



- (void)JSONWithURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"phonenumber": _phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/HomePage", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _recieveArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([tableView isEqual:_addTableView]) {
        return 2;
    }else if ([tableView isEqual:_tableView])
    {
        return TYPE + 1;
    }else
            return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_addTableView]) {
        if (section == 0) {
            return 1;
        }else
            return 2;
    }else
    {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _riceArray.count;
            break;
        case 2:
            return _vegetableArray.count;
            break;
        default:
            return 0;
            break;
    }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_addTableView]) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"请选择您要连接的设备";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *cellID = @"cellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.textLabel.text = _config[indexPath.row];
            return cell;

        }
    }else
    {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
    }

}



- (IBAction)addDevice:(id)sender {
    
//    AddDeviceViewController *viewController = [[AddDeviceViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    [self updateTableViewFrame];
    UIView *leftView = _addBuuton.customView;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(leftView.frame)+self.view.frame.size.width - 25, CGRectGetMidY(leftView.frame) + 55);
    [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionDown withContentView:self.addTableView inView:self.tabBarController.view];
    __weak typeof (self)weakSelf = self;
    self.popover.didDismissHandler = ^{
        [weakSelf bounceTargetView:leftView];
    };

}

- (void)updateTableViewFrame
{
    CGRect tableViewFrame = self.addTableView.frame;
    tableViewFrame.size.width = popoverWidth;
    self.addTableView.frame = tableViewFrame;
}

- (void)bounceTargetView:(UIView *)targetView
{
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.5 delay:3 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        targetView.transform = CGAffineTransformIdentity;
    } completion:nil];
}


@end
