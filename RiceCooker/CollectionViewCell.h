//
//  CollectionViewCell.h
//  RiceCooker
//
//  Created by yi on 15/10/26.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_Commodity.h"
#define kRate [UIScreen mainScreen].bounds.size.width/414

@protocol CollectionCellDelegate <NSObject>

- (void)clickBtnWithCommodity:(DM_Commodity *)commodity;

@end



@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *shopBtn;
@property (nonatomic, weak) id<CollectionCellDelegate> delegate;
@property (nonatomic, strong) DM_Commodity *commodity;
@property (nonatomic, copy) void (^shopCartBlock)(UIImageView *imageView);
- (void)setCommodity:(DM_Commodity *)commodity;
+ (id)collectCell;
@end
