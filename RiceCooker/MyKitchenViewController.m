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
#import "EriceCell.h"
#import "DM_ERiceCell.h"
#import "DM_EVegetable.h"
#import "EVegetabelCell1.h"

#define TYPE 2
#define kRice 0
#define kVegetable 1
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
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIImage *addImage;
@property (nonatomic, strong) UIImage *cancelImage;
@end

@implementation MyKitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的厨房";
    
    _addImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-添加.png" ofType:nil]];
    
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 31, 31)];
    [_addBtn setImage:_addImage forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    _addBuuton = [[UIBarButtonItem alloc] initWithCustomView:_addBtn];
    self.navigationItem.rightBarButtonItem = _addBuuton;
    
   
    
    
    UITableView *blueView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, AddCellHeight*2) style:UITableViewStylePlain];
    
    
    blueView.dataSource = self;
    blueView.delegate = self;
    self.addTableView = blueView;
//    self.addTableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self resetPopover];
    _config = [NSArray arrayWithObjects:@"e饭宝", @"e菜宝", nil];
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self JSONWithURL];
}

- (void)JSONWithURL
{
    _riceArray = [[NSMutableArray alloc] init];
    _vegetableArray = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"phonenumber": _phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/HomePage", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);

        _recieveArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (int i = 0; i<_recieveArray.count; i++) {
            NSLog(@"%@",_recieveArray);
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
        return TYPE;
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
            return _riceArray.count;
            
            break;
        case 1:
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
        
        if(indexPath.section == kRice)
        {
            EriceCell *cell = [tableView dequeueReusableCellWithIdentifier:[EriceCell cellID]];
            if (cell == nil) {
                cell = [EriceCell ericeCell];
            }
            DM_ERiceCell *riceCell = [DM_ERiceCell eRiceWithDict:_riceArray[indexPath.row]];
            cell.riceCell = riceCell;
            return cell;
            

        }else //if (indexPath.section == kVegetable)
        {
            DM_EVegetable *vegetable = [DM_EVegetable eVegetableWithDict:_vegetableArray[indexPath.row]];
            EVegetabelCell1 *cell = [tableView dequeueReusableCellWithIdentifier:[EVegetabelCell1 cellID]];
            if (cell == nil) {
                cell = [EVegetabelCell1 eVegetableCell];
            }
            cell.vegetable = vegetable;
            if ([vegetable.devicename isEqualToString:@"e菜宝上"]) {
                cell.vegetable = vegetable;
            }else if([vegetable.devicename isEqualToString:@"e菜宝中"])
            {
                cell.vegetable2 = vegetable;
            }else
                cell.vegetable3 = vegetable;
            
            
            return cell;
        }
        
    }return nil;
    
    
}


#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_addTableView]) {

        AddDeviceViewController *viewController = [[AddDeviceViewController alloc] initWithNibName:@"AddDeviceViewController" bundle:nil];
        [self.popover dismiss];
        viewController.device = _config[indexPath.row];
        viewController.phoneNumber = self.phoneNumber;
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        
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
        return 137;
}






- (IBAction)addDevice:(id)sender {
    NSLog(@"%@", _addBtn.imageView.image);
    if ([_addBtn.imageView.image isEqual:_addImage]) {
        NSLog(@"yes");
        [self updateTableViewFrame];
        UIView *leftView = _addBuuton.customView;
        CGPoint startPoint = CGPointMake(CGRectGetMidX(self.addBtn.frame) , CGRectGetMinY(self.addBtn.frame) + 50);
        
        [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionDown withContentView:self.addTableView inView:self.tabBarController.view];
        _cancelImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-关闭.png" ofType:nil]];
        [self.addBtn setImage:_cancelImage forState:UIControlStateNormal];
        self.title = @"添加设备";
        __weak typeof (self)weakSelf = self;
        self.popover.didDismissHandler = ^{
            [weakSelf bounceTargetView:leftView];
        };

    }else if([_addBtn.imageView.image isEqual:_cancelImage])
    {
        [self.popover dismiss];
    }
    
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
        
        [_addBtn setImage:_addImage forState:UIControlStateNormal];
        self.title = @"我的厨房";

    } completion:nil];
}


@end
