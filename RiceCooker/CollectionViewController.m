//
//  CollectionViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/26.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "CommodityDetailViewController.h"
#import "DM_Commodity.h"
#define kRate [UIScreen mainScreen].bounds.size.width/414
@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
static NSString *kNameKey = @"nameKey";
static NSString *kImageKey = @"imageKey";
static NSString *kPriceKey = @"priceKey";
- (id)init
{
   self = [super init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(136*kRate, 191*kRate);
     layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(414*kRate, 30.0f*kRate);
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self setBarImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kRate*414, 30.f*kRate)];
    label.textColor = UIColorFromRGB(0x657684);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _type;
    label.font = [UIFont systemFontOfSize:11.0f*kRate];
    label.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [self.collectionView addSubview:label];
   
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    NSDictionary *numberItem = [self.contentList objectAtIndex:indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:[numberItem valueForKey:kImageKey]];
//    NSString *str = [numberItem valueForKey:kNameKey];
//    if (str.length > 14) {
//        cell.titleLabel.text = [numberItem valueForKey:kNameKey];
//    }else
//    cell.titleLabel.text = [NSString stringWithFormat:@"%@\n", [numberItem valueForKey:kNameKey]];
////    cell.titleLabel.text = [numberItem valueForKey:kNameKey];
//    cell.priceLabel.text = [numberItem valueForKey:kPriceKey];
    
    DM_Commodity *commodity = _contentList[indexPath.row];
    cell.commodity = commodity;
    cell.shopBtn.userInteractionEnabled = NO;
    return cell;
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


#pragma mark <UICollectionViewDelegate>


#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(137*kRate, 191*kRate);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityDetailViewController *viewController = [[CommodityDetailViewController alloc] init];
    NSLog(@"item======%ld",(long)indexPath.item);
    NSLog(@"row=======%ld",(long)indexPath.row);
    NSLog(@"section===%ld",(long)indexPath.section);
    viewController.allItem = _contentList;
    viewController.commodity = _contentList[indexPath.row];

    [self.navigationController pushViewController:viewController animated:YES];
}




//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        reusableView =
//    }
//    return reusableView;
//}

@end
