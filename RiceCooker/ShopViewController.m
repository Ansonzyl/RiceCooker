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
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@interface ShopViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *localButton;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong)CLLocationManager *locationManager;
- (IBAction)detail:(UIButton *)sender;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self startStandardUpdates];
    [self setBarImage];

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


- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500; // meters
    
    [_locationManager startUpdatingLocation];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
        [_locationManager requestWhenInUseAuthorization];
    
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
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
//     UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
//    [flowLayout setItemSize:CGSizeMake(90, 90)];
    CollectionViewController *viewController = [[CollectionViewController alloc] init];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
