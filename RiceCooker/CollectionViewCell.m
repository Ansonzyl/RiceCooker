//
//  CollectionViewCell.m
//  RiceCooker
//
//  Created by yi on 15/10/26.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CollectionViewCell.h"
#import "DM_UIConten.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [self setLabelAndImage];
}

+ (id)collectCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil][0];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setLabelAndImage];
    }
    return self;
}




- (void)setLabelAndImage
{
    DM_UIConten *ui = [[DM_UIConten alloc] init];
    CGFloat size = 126*kRate;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*kRate, 5*kRate, size, size)];
    
    UIButton *shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*kRate, 161*kRate, 16*kRate, 14*kRate)];
//    UIButton *shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 161, 16, 14)];
    [shopBtn setImage:[UIImage imageNamed:@"icon-购物车(48 42).png"] forState:UIControlStateNormal];
    
    _titleLabel = [ui initializeLabelWithFrame:CGRectMake(5*kRate, 138*kRate, 120*kRate, 30*kRate) withText:nil withSize:10];
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*kRate, 138*kRate, 120*kRate, 30*kRate)];
//    _titleLabel.font = [UIFont systemFontOfSize:10];
    
    _titleLabel.textColor = UIColorFromRGB(0x505050);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 2;
    

    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*kRate, 158*kRate, 50*kRate, 30*kRate)];
    _priceLabel.font = [UIFont systemFontOfSize:9];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.textColor = UIColorFromRGB(0xff5a00);
    [self addSubview:_imageView];
    [self addSubview:_titleLabel];
    [self addSubview:_priceLabel];
    [self addSubview:shopBtn];
    

}

- (void)addToShop
{
    
}


@end
