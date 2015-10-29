//
//  CartCell.h
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_Commodity.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414

@protocol CartCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag;

@end

@interface CartCell : UITableViewCell
@property (nonatomic, strong) UIImageView *check;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel  *priceLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) DM_Commodity *commidity;
@property (nonatomic, weak) id<CartCellDelegate> delegate;

- (void)setCommidity:(DM_Commodity *)commidity;

@end
