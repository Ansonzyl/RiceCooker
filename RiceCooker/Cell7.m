//
//  Cell7.m
//  RiceCooker
//
//  Created by yi on 15/11/1.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell7.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@implementation Cell7

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)initializeWithBundle
{
    Cell7 *cell = [[NSBundle mainBundle] loadNibNamed:@"Cell7" owner:nil options:nil][0];
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"Cell7" owner:nil options:nil][0];
        [self setlabel];
    }
    return self;
}

- (void)setlabel
{
    CGRect frame = CGRectMake(135*kRate, 11, 50, 15);
    
    _commodityPrice = [self LabelWithFrame:frame];
    frame.origin.y = 34;
    _packingFee = [self LabelWithFrame:frame];
    frame.origin.y = 57;
    _discount = [self LabelWithFrame:frame];
    
    [self.contentView addSubview:_packingFee];
    [self.contentView addSubview:_commodityPrice];
    [self.contentView addSubview:_discount];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(212*kRate, 9, 1, 62)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:line];
    CGRect frame1 = CGRectMake(285*kRate, 11, 50, 15);
//    frame1.origin.x = line.frame.origin.x+
    UILabel *label = [self LabelWithFrame:frame1];
    label.text = @"总金额";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(0x505050);
    [self.contentView addSubview:label];
    _totalPrice = [self LabelWithFrame:CGRectMake(270*kRate, 37, 100, 21)];
    CGPoint point = _totalPrice.center;
    point.x = label.center.x;
    _totalPrice.center = point;
    _totalPrice.textAlignment = NSTextAlignmentCenter;
    _totalPrice.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_totalPrice];
    
}

- (UILabel *)LabelWithFrame:(CGRect )frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = UIColorFromRGB(0x40c8c4);
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentRight;
    return label;
}


@end
