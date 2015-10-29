//
//  CollectionViewCell.h
//  RiceCooker
//
//  Created by yi on 15/10/26.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRate [UIScreen mainScreen].bounds.size.width/414
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;


+ (id)collectCell;
@end
