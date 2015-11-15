//
//  ShopViewController.m
//  RiceCooker
//
//  Created by yi on 15/11/4.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "ShopViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CollectionViewController.h"
#import "DM_UserMessage.h"
#import "AddressCell.h"
#import "AddNewAddressCell.h"
#import "DM_Commodity.h"
#import "CollectionViewCell.h"
#import "CollectionViewController.h"
#import "ReusableViewHeader.h"
#import "CartViewController.h"
#import "CommodityDetailViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define RowHeight 57



@interface ShopViewController ()<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, reusableDelegate, CollectionCellDelegate>
{
    CALayer *_layer;
    CAShapeLayer *_shapeLayer;
   
    
}

@property (strong, nonatomic) IBOutlet UIButton *localButton;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong)CLLocationManager *locationManager;

@property (nonatomic, strong) UITableView *topTable;
@property (nonatomic, strong) UIControl *overlay;
@property (nonatomic, strong) DM_Commodity *comm;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSMutableArray *contentList;
@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, strong) UILabel *cartLabel;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic,strong) UIBezierPath *path;
- (IBAction)detail:(UIButton *)sender;



@end

@implementation ShopViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";

- (void)viewDidLoad {
    
    [self initializeCollectionView];
    [self locationBtn];
    [super viewDidLoad];
    [self userInformation];
    [self setBarImage];
    [self startStandardUpdates];
    [self setImage];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self setTopTableView];
    });
    
   

    
    
    
    _contentList = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"collection" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
   
    [self setArrayWithArray:[dic objectForKey:@"rice"]];
    [self setArrayWithArray:[dic objectForKey:@"vegetable"]];
    
    [self initializeCartButton];
    
}

- (void)initializeCartButton
{
    CGRect frame = CGRectMake(390*kRate, 630*kRate, 24*kRate, 11*kRate);
    
    _cartLabel = [[UILabel alloc] initWithFrame:frame];
    _cartLabel.textColor = [UIColor whiteColor];
    _cartLabel.font = [UIFont systemFontOfSize:11*kRate];
    frame.origin.x = 346*kRate;

    _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(346*kRate, 609*kRate, 62*kRate, 50*kRate)];

    
    _cartButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_cartButton addTarget:self action:@selector(pushToCartView) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)pushToCartView
{
    CartViewController *viewController = [[CartViewController alloc] init];
    viewController.cartArray = _cartArray;
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void) initializeCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    UINib *nib = [UINib nibWithNibName:@"ReusableViewHeader" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusable"];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
    
}

- (void)setArrayWithArray:(NSArray *)list;
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i< list.count; i++) {
        DM_Commodity *commodity = [DM_Commodity commodityWithDict:list[i]];
        [array addObject:commodity];
    }
    [_contentList addObject:array];
}

- (void)setImage
{
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30*kRate, kWidth, 102*kRate)];
    image1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"我常买" ofType:@"png"]];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 132*kRate, kWidth, 137*kRate)];
    image2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ad" ofType:@"png"]];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 270*kRate, kWidth, 138*kRate)];
    image3.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"商城2" ofType:@"png"]];
    
    CGRect frame = CGRectMake(0, 407*kRate, kWidth / 2, 68*kRate);
    UIButton *rice = [[UIButton alloc] initWithFrame:frame];
    [rice setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"稻谷米" ofType:@"png"]] forState:UIControlStateNormal];
    rice.tag = 11;
    [rice addTarget:self action:@selector(gotoMoreView:withString:) forControlEvents:UIControlEventTouchUpInside];
    frame.origin.x = kWidth/2 + 1;
    UIButton *vegetable = [[UIButton alloc] initWithFrame:frame];
    vegetable.tag = 22;
    [vegetable setBackgroundImage: [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"配菜" ofType:@"png"]] forState:UIControlStateNormal];
    [vegetable addTarget:self action:@selector(gotoMoreView:withString:) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:rice];
    [self.collectionView addSubview:vegetable];
    [self.collectionView addSubview:image1];
    [self.collectionView addSubview:image2];
    [self.collectionView addSubview:image3];
}


- (void)gotoMoreView:(UIButton *)sender withString:(NSString *)str;
{
    CollectionViewController *viewController = [[CollectionViewController alloc] init];
    [viewController setHidesBottomBarWhenPushed:YES];
    
    if (sender.tag == 11) {
        viewController.contentList = self.contentList[0];
        viewController.type = @"稻谷｜米";
    }else if(sender.tag == 22)
    {
        viewController.contentList = self.contentList[1];
        viewController.type = @"配菜";
    }else
    {
        viewController.type = str;
        if ([str isEqualToString: @"稻谷｜米"]) {
            viewController.contentList = self.contentList[0];
        }else
        {
            viewController.contentList = self.contentList[1];
        }
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark delegate
- (void)clickBtnWithButton:(UIButton *)button withTitle:(NSString *)string
{

    [self gotoMoreView:button withString:string];
}

- (void)setTopTableView
{
    CGFloat kH = (_addressArray.count + 1)*RowHeight;
    _topTable = [[UITableView alloc] initWithFrame:CGRectMake(0, - kH, kWidth, kH) style:UITableViewStylePlain];
    _topTable.delegate = self;
    _topTable.dataSource = self;
    _topTable.rowHeight = RowHeight;
    if ([self.topTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.topTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.topTable respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.topTable setLayoutMargins:UIEdgeInsetsZero];
    }

    
}

- (void)locationBtn
{
    _localButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, kWidth, 30*kRate)];
    [_localButton setTitleColor:UIColorFromRGB(0x657684) forState:UIControlStateNormal];
    _localButton.titleLabel.font = [UIFont systemFontOfSize:11*kRate];
//    [_localButton setTitle:@"11111" forState:UIControlStateNormal];
    [_localButton addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    _localButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    [self.collectionView addSubview:_localButton];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -------<UICollectionViewDataSource>-----

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0)
    {
        return 0;
    }else
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
        return cell;
    }else
    {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

        DM_Commodity *commodity = [_contentList[indexPath.section - 1] objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.commodity = commodity;
        cell.backgroundColor = [UIColor whiteColor];
        __block CollectionViewCell *newCell = cell;
        cell.shopCartBlock = ^(UIImageView *imageView){
            CGRect rect = [newCell convertRect:newCell.shopBtn.frame toView:self.view];
            [self startAnimationWithRect:rect ImageView:imageView];
            
        };
        return cell;

    }
   
   
}

-(void)startAnimationWithRect:(CGRect)rect ImageView:(UIImageView *)imageView
{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.contents = (id)imageView.layer.contents;
        
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = rect;
        _layer.cornerRadius = CGRectGetHeight(_layer.bounds) / 2;
        _layer.masksToBounds = YES;
        _layer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        
        [self.view.layer addSublayer:_layer];
        self.path = [UIBezierPath bezierPath];
        [_path moveToPoint:_layer.position];
        [_path addQuadCurveToPoint:_cartButton.center controlPoint:CGPointMake(rect.origin.x + 10, rect.origin.y - 80)];
    }
    [self groupAnimation];
    
}

- (void)groupAnimation
{
    self.collectionView.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    expandAnimation.duration = 0.15f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.15f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 1.0f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
        self.collectionView.userInteractionEnabled = YES;
        
        [_layer removeFromSuperlayer];
        _layer = nil;
        _cartLabel.hidden = NO;
        [self cartShop];
         _cartLabel.text = [NSString stringWithFormat:@"%d", (int)_cartArray.count];
        
    }
}


- (void)clickBtnWithCommodity:(DM_Commodity *)commodity
{
    BOOL isExist = NO;
    int i ;
    for ( i = 0; i<_cartArray.count; i++) {
        DM_Commodity *com = _cartArray[i];

        if ([commodity.nameKey isEqual:com.nameKey]) {
            isExist = YES;
            break;

        }else
        {

        }
    }
    if (isExist) {
        DM_Commodity *com = _cartArray[i];
        com.count = [NSString stringWithFormat:@"%d",([com.count intValue] + 1)];

        [_cartArray replaceObjectAtIndex:i withObject:com];

    }else
    {
        commodity.count = @"1";
        [_cartArray addObject:commodity];

    }

}




#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGSize size = {kWidth, 480*kRate};
        return size;
    }else
    {
        CGSize size = {kWidth, 31};
        return size;
    }
    
}




#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(136*kRate, 191*kRate);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ReusableViewHeader *headerView = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusable" forIndexPath:indexPath];
        if (indexPath.section == 0)
        {
            headerView.labelText.hidden = YES;
            headerView.button.hidden = YES;

        }else if (indexPath.section == 1)
        {
            headerView.labelText.text = @"稻谷｜米";
            headerView.labelText.hidden = NO;
            headerView.button.hidden = NO;

        }
        else if (indexPath.section == 2)
        {
            headerView.labelText.text = @"配菜";
            headerView.labelText.hidden = NO;
            headerView.button.hidden = NO;
        }
    }
    headerView.delegate = self;
    return headerView;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityDetailViewController *viewController = [[CommodityDetailViewController alloc] init];
//    NSLog(@"item======%ld",(long)indexPath.item);
//    NSLog(@"row=======%ld",(long)indexPath.row);
//    NSLog(@"section===%ld",(long)indexPath.section);
    viewController.allItem = _contentList[indexPath.section - 1];
    viewController.commodity = [_contentList[indexPath.section - 1] objectAtIndex:indexPath.row];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
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
        
        return cell;

    }else
    {
        AddNewAddressCell *cell = [[AddNewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressNewCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
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




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
    [self dismiss];
    [self setAddress];
    [_localButton removeFromSuperview];
    [_cartButton removeFromSuperview];
    [self encodeArray];
    
}

- (void)encodeArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_cartArray.count; i++) {
        [array addObject:[(DM_Commodity *)_cartArray[i] encodedItem]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"CartArray"];

}


- (void)setAddress
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_addressArray.count; i++) {
        [array addObject:[(DM_UserMessage *)_addressArray[i] encodedItem]];
    }
    [_userDefaults setObject:array forKey:@"addressArray"];
}



// 地址定位

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
            
            NSString* address = [NSString stringWithFormat:@"            %@ %@ %@ %@ %@ %@",
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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [self.navigationController.view insertSubview:_localButton aboveSubview:self.collectionView];
    [self.navigationController.view insertSubview:_cartButton aboveSubview:self.collectionView];
    [self.navigationController.view insertSubview:_cartLabel aboveSubview:self.collectionView];
    _array = [_userDefaults objectForKey:@"CartArray"];
    _cartArray = [NSMutableArray array];
    for (int i = 0; i<_array.count; i++) {
        DM_Commodity *com = [DM_Commodity commodityWithDict:_array[i]];
        [_cartArray addObject:com];
    }
    [self cartShop];
    

}

- (void)cartShop
{
    NSString *imageName;
    

        

    if (_cartArray.count > 0) {
        imageName = @"icon-购物车(186 150).png";
        _cartLabel.text = [NSString stringWithFormat:@"%d", (int)_cartArray.count];
        _cartLabel.hidden = NO;
    }else
    {
        _cartLabel.hidden = YES;
        imageName = @"icon-购物车(150 150).png";
    }
    
    [_cartButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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
    
    
       [self setTopView];
    
}

- (void)setTopView
{
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.topTable selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    CGFloat h = CGRectGetHeight(self.localButton.frame) + CGRectGetHeight(self.navigationController.navigationBar.frame) + 20;
    _overlay = [[UIControl alloc] initWithFrame:CGRectMake(0, h, kWidth, CGRectGetHeight(self.view.frame))];
    _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_overlay addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _overlay.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:_overlay];
//    [self.navigationController insertSubview:_overlay aboveSubview:_cartButton];
    [self.view insertSubview:_topTable belowSubview:self.navigationController.navigationBar];
    [self.view insertSubview:_topTable belowSubview:self.localButton];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _topTable.frame;
        frame.origin.y = h;
        _topTable.frame = frame;
        
    } completion:^(BOOL finished) {
        _localButton.userInteractionEnabled = NO;
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
        _localButton.userInteractionEnabled = YES;
    }];
}






@end
