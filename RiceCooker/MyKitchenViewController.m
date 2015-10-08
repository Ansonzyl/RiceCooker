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
#import "SYQRCodeViewController.h"

#define kRate [UIScreen mainScreen].bounds.size.width / 414
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

@property (nonatomic, strong) NSMutableArray *devicesArray;
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LabelContentList" ofType:@"plist"];
    _config = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"addDevices"];

    
    
    
    UITableView *blueView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popoverWidth, AddCellHeight*_config.count) style:UITableViewStylePlain];
    
    
    blueView.dataSource = self;
    blueView.delegate = self;
    self.addTableView = blueView;
//    self.addTableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self resetPopover];
    
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
    
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
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
        return TYPE;
    }else
            return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_addTableView]) {
//        if (section == 0) {
//            return 1;
//        }else
            return _config.count;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
//            DM_ERiceCell *riceCell = [DM_ERiceCell eRiceWithDict:_riceArray[indexPath.row]];
            DM_EVegetable *device = [DM_EVegetable eVegetableWithDict:_riceArray[indexPath.row]];
            cell.device = device;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }return nil;
    
    
}


#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加设备
    if ([tableView isEqual:_addTableView]) {
        AddDeviceViewController *viewController = [[AddDeviceViewController alloc] initWithNibName:@"AddDeviceViewController" bundle:nil];
        [self.popover dismiss];
       
        viewController.phoneNumber = self.phoneNumber;
        [viewController setHidesBottomBarWhenPushed:YES];

        if (indexPath.row == 2) {
                       SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
            [self.navigationController pushViewController:qrcodevc animated:YES];

            qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
                NSArray *array = [qrString componentsSeparatedByString:@","];
                viewController.device = array[0];
                viewController.UUID = array[1];
                [aqrvc.navigationController pushViewController:viewController animated:YES];
            };
            qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
                [self showTopMessage:@"扫描失败，请重试"];
                
            };
            qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
                [aqrvc dismissViewControllerAnimated:NO completion:nil];
                
            };
            

        }else
        {
             viewController.device = _config[indexPath.row];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
    }else
    {
        // 设备主页
        
//        ViewController *viewController = [[ViewController alloc] initWithNibName:@"DevicesViewController" bundle:nil];
//        
//        
        DevicesViewController *viewController = [[DevicesViewController alloc] initWithNibName:@"DevicesViewController" bundle:nil];
        
        
        _devicesArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<_riceArray.count; i++) {
            DM_EVegetable *riceCell = [DM_EVegetable eVegetableWithDict:_riceArray[i]];
            [_devicesArray addObject:riceCell];
                   }
        for (int i = 0; i<_vegetableArray.count; i++) {
            DM_EVegetable *vegetable = [DM_EVegetable eVegetableWithDict:_vegetableArray[i]];
            [_devicesArray addObject:vegetable];

        }
        viewController.devicesArray = _devicesArray;
        
        NSLog(@"%ld", (long)indexPath.row);
        if (indexPath.section == 0) {
            viewController.currentNumber = indexPath.row;
            
        }else
        {
            viewController.currentNumber = indexPath.row + _riceArray.count;
        }
        [viewController setHidesBottomBarWhenPushed:YES];
        

        
        [self.navigationController pushViewController:viewController animated:YES];
        
       
        
      
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_addTableView]) {
        return AddCellHeight;
        
    }else
        return 137*kRate;
}






- (IBAction)addDevice:(id)sender {
    
    if ([_addBtn.imageView.image isEqual:_addImage]) {
        
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
