//
//  ShopViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/25.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "ShopViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CollectionViewController.h"
#import "DM_UserMessage.h"
#import "AddressCell.h"
#import "AddNewAddressCell.h"

#define kRate [UIScreen mainScreen].bounds.size.width / 414
#define kWidth [UIScreen mainScreen].bounds.size.width
#define RowHeight 57

@interface ShopViewController () <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *localButton;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong) UITableView *topTable;
@property (nonatomic, strong) UIControl *overlay;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSUserDefaults *userDefaults;

- (IBAction)detail:(UIButton *)sender;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self startStandardUpdates];
    [self setBarImage];
    [self userInformation];
    _userDefaults = [NSUserDefaults standardUserDefaults];
//    _addressArray = [_userDefaults objectForKey:@"addressArray"];
    
    
    CGFloat kH = (_addressArray.count + 1)*RowHeight;
    _topTable = [[UITableView alloc] initWithFrame:CGRectMake(0, - kH, kWidth, kH)];
    _topTable.delegate = self;
    _topTable.dataSource = self;
    _topTable.rowHeight = RowHeight;
    
    _localButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}

- (void)setBarImage
{
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 17)];
    titleImage.image = [UIImage imageNamed:@"icon-点点商城.png"];
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    titleImage.center = titleView.center;
    [titleView addSubview:titleImage];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _addressArray.count;
    }else
    {
    return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellID = @"addressCell";
        AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [AddressCell addressCell];
        }
        cell.userMessage = (DM_UserMessage *)_addressArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.selected = YES;
        return cell;

    }else
    {
        AddNewAddressCell *cell = [[AddNewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressNewCell"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DM_UserMessage * address = [_addressArray objectAtIndex:indexPath.row];
        NSLog(@"%@", address.userAddress);
        [_localButton setTitle:address.userAddress  forState:UIControlStateNormal];
        [_addressArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [self.topTable reloadData];
        [self dismiss];
    }else
    {
        
    }
}




- (void)userInformation
{
    NSMutableArray *array = [NSMutableArray array];
    DM_UserMessage *msg = [[DM_UserMessage alloc] init];
    msg.userName = @"骆建松";
    msg.userPhone = @"18698558701";
    msg.userAddress = @"杭州市滨江区六和路368号，杭州点厨科技有限公司。";
    [array addObject:msg];
    DM_UserMessage *msg2 = [[DM_UserMessage alloc] init];
    msg2.userName = @"骆建松";
    msg2.userPhone = @"18698558701";
    msg2.userAddress = @"杭州市滨江区风雅钱塘4幢1004室";
    [array addObject:msg2];
    _addressArray = [NSMutableArray arrayWithArray:array];
    
}



- (void)startStandardUpdates
{
        if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
        _locationManager.distanceFilter = 500; // meters
    
    [_locationManager startUpdatingLocation];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
        [_locationManager requestWhenInUseAuthorization];
    
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
    [self dismiss];
    [self setAddress];
}


- (void)setAddress
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_addressArray.count; i++) {
        [array addObject:[(DM_UserMessage *)_addressArray[i] encodedItem]];
    }
    [_userDefaults setObject:array forKey:@"addressArray"];
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    [self reverseGeocode:currentLocation];
    [self.locationManager stopUpdatingLocation];
}




- (void)reverseGeocode:(CLLocation *)location
{
    if (!_geocoder)
    {
        _geocoder = [[CLGeocoder alloc] init];
    }
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (nil != error) {
            
        }else if ([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"%@\n%@",placemark.thoroughfare,placemark.subThoroughfare);
     
            NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",
                                 placemark.country,
                                 placemark.administrativeArea,
                                 placemark.locality,
                                 placemark.subLocality,
                                 placemark.thoroughfare,
                                 placemark.subThoroughfare];
            
            [_localButton setTitle:address forState:UIControlStateNormal];
        }
        
        
    }];
    
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // 提示用户出错原因
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void) setNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)detail:(UIButton *)sender {

    CollectionViewController *viewController = [[CollectionViewController alloc] init];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    
//    [self setTopView];
    
}

- (void)setTopView
{
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.topTable selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    CGFloat h = CGRectGetHeight(self.localButton.frame) + CGRectGetHeight(self.navigationController.navigationBar.frame) + 20;
    _overlay = [[UIControl alloc] initWithFrame:CGRectMake(0, h+CGRectGetHeight(_topTable.frame), kWidth, CGRectGetHeight(self.view.frame))];
    _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_overlay addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _overlay.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [self.view insertSubview:_topTable belowSubview:self.navigationController.navigationBar];
    [self.view insertSubview:_topTable belowSubview:self.localButton];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _topTable.frame;
        frame.origin.y = h;
        _topTable.frame = frame;
        [self.view addSubview:_overlay];
    } completion:^(BOOL finished) {
        
    }];
 
}


- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _topTable.frame;
        frame.origin.y = - RowHeight * 2;
        _topTable.frame = frame;

    } completion:^(BOOL finished) {
        [self.overlay removeFromSuperview];
        [_topTable removeFromSuperview];
    }];
}


@end
