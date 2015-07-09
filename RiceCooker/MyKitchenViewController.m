//
//  MyKitchenViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyKitchenViewController.h"
#import "DXPopover.h"
#import "AddDeviceViewController.h"
#import "ERiceViewController.h"
#define TYPE 2
#define kRice 1
#define kVegetable 2
#import "AddDeviceCell.h"
#define AddCellHeight 58


@interface MyKitchenViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat popoverWidth;
}
@property (nonatomic, strong) NSArray *recieveArray;
@property (nonatomic, strong) NSMutableArray *riceArray;
@property (nonatomic, strong) NSMutableArray *vegetableArray;
@property (nonatomic, strong) UIBarButtonItem *addBuuton;
@property (nonatomic, strong) UITableView *addTableView;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) NSArray *config;
@property (nonatomic, strong) UIView *overView;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation MyKitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的厨房";
//    _addBuuton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDevice:)];
   
//    _addBuuton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-添加.png" ofType:nil]] style:UIBarButtonItemStylePlain target:self action:@selector(addDevice:)];
//    _addBuuton.image = [UIImage imageNamed:@"icon-添加.png"];
//     self.navigationItem.rightBarButtonItem = _addBuuton;
    
//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.bounds = CGRectMake(0, 0, 23, 23);
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 31, 31)];
    [_addBtn setImage:[UIImage imageNamed:@"icon-添加.png"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    _addBuuton = [[UIBarButtonItem alloc] initWithCustomView:_addBtn];
    self.navigationItem.rightBarButtonItem = _addBuuton;
    
    
    
    
    UITableView *blueView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, AddCellHeight*2) style:UITableViewStylePlain];
    
    
    blueView.dataSource = self;
    blueView.delegate = self;
    self.addTableView = blueView;
//    self.addTableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self resetPopover];
    _config = [NSArray arrayWithObjects:@"e饭宝", @"e菜宝", nil];
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    _recieveArray = [NSMutableArray array];
    _vegetableArray = [[NSMutableArray alloc] init];
    
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
        for (int i = 0; i<_recieveArray.count; i++) {
            if ([[_recieveArray[i] objectForKey:@"device"] isEqualToString:@"e饭宝"]) {
                [_riceArray addObject:_recieveArray[i]];
            }else if ([[_recieveArray[i] objectForKey:@"device"] isEqualToString:@"e菜宝"])
            {
                [_vegetableArray addObject:_recieveArray[i]];
            }
        }
        [self.tableView reloadData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([tableView isEqual:_addTableView]) {
        return 1;
    }else if ([tableView isEqual:_tableView])
    {
        return TYPE + 1;
    }else
            return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_addTableView]) {
//        if (section == 0) {
//            return 1;
//        }else
            return 2;
    }else
    {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
//            return _riceArray.count;
            return 2;
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
    
   UITableViewCell *cell = nil;
    
    
    if ([tableView isEqual:_addTableView]) {
        
        if (indexPath.section == 0) {
            AddDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddDeviceCell ID]];
            if (cell == nil) {
                cell = [AddDeviceCell AddDeviceCell];
            }
            NSString *image = [NSString stringWithFormat:@"icon-%@.png", _config[indexPath.row]];
            cell.logoImage.image = [UIImage imageNamed:image];
            cell.myLebel.text = _config[indexPath.row];
            
            return cell;

        }
    }else
    {
        static NSString *riceID = @"reiceID";
        static NSString *vegetableID = @"vegetableID";
        if (indexPath.section == 0) {
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"welcome";
            
        }else if(indexPath.section == kRice)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:riceID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:riceID];
                cell.textLabel.text = @"e饭宝";
            }
            return cell;

        }else if (indexPath.section == kVegetable)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:vegetableID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] init];
                cell.textLabel.text = @"e菜宝";
            }
        }
    }
    return cell;
}


#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_addTableView]) {

            AddDeviceViewController *viewController = [[AddDeviceViewController alloc] initWithNibName:@"AddDeviceViewController" bundle:nil];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            [self presentViewController:viewController animated:YES completion:^{
                
            }];
//        }
        
    }else
    {
        if (indexPath.section == 1) {
            ERiceViewController *viewController = [[ERiceViewController alloc] initWithNibName:@"ERiceViewController" bundle:nil];
            

            [self presentViewController:viewController animated:YES completion:^{
                
            }];
            
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_addTableView]) {
        return AddCellHeight;
        
    }else
        return 44;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}





- (IBAction)addDevice:(id)sender {
    
    [self updateTableViewFrame];
    UIView *leftView = _addBuuton.customView;
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(leftView.frame)+self.view.frame.size.width - 25, CGRectGetMidY(leftView.frame) + 55);
//    NSLog(@"%@", self.tabBarController.view);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.addBtn.frame) , CGRectGetMinY(self.addBtn.frame) + 50);
  
    
    [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionDown withContentView:self.addTableView inView:self.tabBarController.view];
    [self.addBtn setImage:[UIImage imageNamed:@"icon-关闭.png"] forState:UIControlStateNormal];
    self.title = @"添加设备";
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
        [_addBtn setImage:[UIImage imageNamed:@"icon-添加.png"] forState:UIControlStateNormal];
        self.title = @"我的厨房";

    } completion:nil];
}


@end
