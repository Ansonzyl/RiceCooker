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
    
    _shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*kRate, 161*kRate, 16, 14)];

    [_shopBtn setImage:[UIImage imageNamed:@"icon-购物车(48 42).png"] forState:UIControlStateNormal];
    [_shopBtn addTarget:self action:@selector(addToShop) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel = [ui initializeLabelWithFrame:CGRectMake(5*kRate, 138*kRate, 120*kRate, 30*kRate) withText:nil withSize:10];

    
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
    [self addSubview:_shopBtn];
    

}

- (void)setCommodity:(DM_Commodity *)commodity
{
    _commodity = commodity;
    self.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:commodity.imageKey ofType:@"png"]];
    NSString *str = commodity.nameKey;
    if (str.length > 14) {
        self.titleLabel.text = str;
    }else
        self.titleLabel.text = [NSString stringWithFormat:@"%@\n", str];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", commodity.priceKey];

}


- (void)addToShop
{
    self.shopCartBlock(self.imageView);
    [_delegate clickBtnWithCommodity:self.commodity];
}


@end
