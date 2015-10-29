//
//  CartCell.m
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CartCell.h"
#import "DM_UIConten.h"

@implementation CartCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setImageAndLabel];
    }
    return self;
}


- (void)setImageAndLabel
{
    DM_UIConten *ui = [[DM_UIConten alloc]  init];
    CGFloat size = 23*kRate;
    _check = [ui initializeImageWithFrame:CGRectMake(16*kRate, 36*kRate, size, size) withImageName:@"icon-未选中" withHightlightImage:@"icon-选中"];
    [self.contentView addSubview:_check];
    size = 82*kRate;
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(54*kRate, 12*kRate, size, size)];
    _image.image = [UIImage imageNamed:@"菜1"];
    [self.contentView addSubview:_image];
    
    _titleLabel = [ui initializeLabelWithFrame:CGRectMake(153*kRate, 15*kRate, 143*kRate, 30*kRate) withText:@"name" withSize:11];
    _titleLabel.textColor = UIColorFromRGB(0x505050);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    _priceLabel = [ui initializeLabelWithFrame:CGRectMake(153*kRate, 61*kRate, 143*kRate, 20*kRate) withText:@"$" withSize:12];
    _priceLabel.textColor = UIColorFromRGB(0x40c8c4);
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_priceLabel];
    
    CGFloat height = 54*kRate;
    size = 30*kRate;
    UIButton *subtractBtn = [[UIButton alloc] initWithFrame:CGRectMake(298*kRate, height, size, size)];
    [subtractBtn setImage:[UIImage imageNamed:@"icon-减（购物列表）.png"] forState:UIControlStateNormal];
    [subtractBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    subtractBtn.tag = 5;
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(369*kRate, height, size, size)];
    [plusBtn setImage:[UIImage imageNamed:@"icon-加（购物列表）.png"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn.tag = 6;
    [self.contentView addSubview:subtractBtn];
    [self.contentView addSubview:plusBtn];
    
    _numLabel = [ui initializeLabelWithFrame:CGRectMake(333*kRate, height, 30*kRate, size) withText:@"1" withSize:13];
    _numLabel.textColor = UIColorFromRGB(0x848484);
    
    [self.contentView addSubview:_numLabel];
    
    
}

- (void)changeNumber:(UIButton *)sender
{
//    if (_check.highlighted) {
//        int num = [_numLabel.text intValue];
//        if (sender.tag == 5) {
//            
//            if (num > 1) {
//                num --;
//            }
//        }else
//        {
//            num ++;
//        }
//        _numLabel.text = [NSString stringWithFormat:@"%d", num];
//
//    }
    [self.delegate btnClick:self andFlag:sender.tag];
    
}

- (void)setCommidity:(DM_Commodity *)commidity
{
    _commidity = commidity;
    self.image.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:commidity.imageKey ofType:@"png"]];
    self.titleLabel.text = commidity.nameKey;
    self.priceLabel.text = commidity.priceKey;
    self.numLabel.text = commidity.count;
}


@end
