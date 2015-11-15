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

#import "EriceCell.h"
#import "DM_ERiceCell.h"
#import "DM_EVegetable.h"
#import "EVegetabelCell1.h"
#import "SYQRCodeViewController.h"
#import "Reachability.h"

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
@property (nonatomic, strong) UIRefreshControl *refresh;

@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) NSArray *config;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIImage *addImage;
@property (nonatomic, strong) UIImage *cancelImage;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *devicesArray;
@property (nonatomic, strong) UIView *titleView;
@end

@implementation MyKitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitlePic];
    
    _refresh = [[UIRefreshControl alloc] init];
    [_refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refresh];
    _addImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-添加.png" ofType:nil]];
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 31*kRate, 31*kRate)];
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
    [self setNavigationBar];
    
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//       if ([self netWorkStateWithReachability:reach]) {
        [self JSONWithURL];
//    }
    
}

- (void)pullToRefresh
{
    [self JSONWithURL];
    [self.refresh endRefreshing];
}


//- (void) reachabilityChanged:(NSNotification *)note
//{
//    Reachability* curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
//    [self updateInterfaceWithReachability:curReach];
//}

//- (BOOL)netWorkStateWithReachability:(Reachability *)reachability
//{
//    NetworkStatus netStatus = [reachability currentReachabilityStatus];
//    BOOL isExistenceNetwork;
//    
//    switch (netStatus) {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            NSLog(@"no network");
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            break;
//
//        default:
//            break;
//    }
//    return isExistenceNetwork;
//}


- (void) setNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
    
}

- (void)setTitlePic
{
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 17)];
    _titleImage.image = [UIImage imageNamed:@"icon-点点厨房.png"];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 17)];
    _titleLabel.text = @"添加设备";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = UIColorFromRGB(0xd7ffff);
    _titleLabel.font = [UIFont systemFontOfSize:17];
    
    _titleView = [[UIView alloc] init];
    self.navigationItem.titleView = _titleView;
    _titleLabel.center = _titleView.center;
    _titleImage.center = _titleView.center;
    [_titleView addSubview:_titleLabel];
    [_titleView addSubview:_titleImage];
    _titleLabel.hidden = YES;
    
}




- (void)JSONWithURL
{
    _riceArray = [[NSMutableArray alloc] init];
    _vegetableArray = [[NSMutableArray alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"phonenumber": _phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/HomePage", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject) {
            _recieveArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            for (int i = 0; i<_recieveArray.count; i++) {
               
                    if ([[_recieveArray[i] objectForKey:@"device"] isEqualToString:@"e饭宝"]) {
                        [_riceArray addObject:_recieveArray[i]];
                    }else if ([[_recieveArray[i] objectForKey:@"device"] isEqualToString:@"e菜宝"])
                    {
                        [_vegetableArray addObject:_recieveArray[i]];
                    }
                   

                
            }
            
            
            if (_recieveArray.count) {
                [self.tableView reloadData];
            }
            
        }
        
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showTopMessage:@"连接不上服务器"];
        
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
            if (_config.count > indexPath.row) {
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
            
        }
    }else if ([tableView isEqual:_tableView])
    {
        
        
        if(indexPath.section == kRice)
        {
            if (_riceArray.count > indexPath.row)
            {
                DM_EVegetable *device = [DM_EVegetable eVegetableWithDict:_riceArray[indexPath.row]];
                EriceCell *cell;
                cell = [tableView dequeueReusableCellWithIdentifier:[EriceCell cellID]];
                if (cell == nil) {
                    cell = [EriceCell ericeCell];
                }

                
                cell.device = device;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            

        }else
            
        {
            if (_vegetableArray.count > indexPath.row) {
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
            
        }
        
    }
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    
    
    
    
    
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
                NSArray *array = [qrString componentsSeparatedByString:@" "];
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
        if([((DM_EVegetable *)_devicesArray [viewController.currentNumber]).connectstate intValue] == 1)
        {
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
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
        _titleImage.hidden = YES;
        _titleLabel.hidden = NO;
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
//        [self setTitlePic];
        _titleImage.hidden = NO;
        _titleLabel.hidden = YES;
        
        self.tabBarItem.image = [[UIImage imageNamed:@"icon-我的厨房.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-我的厨房select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];



    } completion:nil];
}



@end
