//
//  RecipeCell.m
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "RecipeCell.h"
#import "DM_UIConten.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@implementation RecipeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLabel];
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f3);
        
    }
    return self;
}




- (void)setLabel
{
    DM_UIConten *ui = [[DM_UIConten alloc] init];
    UILabel *label1 = [ui initializeLabelWithFrame:CGRectMake(15*kRate, 14*kRate, 70*kRate, 15*kRate) withText:@"食材" withSize:13];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = UIColorFromRGB(0x505050);
    [self.contentView addSubview:label1];
    UILabel *label2 = [ui initializeLabelWithFrame:CGRectMake(16*kRate, 33*kRate, 70*kRate, 15*kRate) withText:@"主材：" withSize:11];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.textColor = UIColorFromRGB(0xff5a00);
    [self.contentView addSubview:label2];
    
    _material = [ui initializeLabelWithFrame:CGRectMake(16*kRate, 52*kRate, 320*kRate, 14*kRate) withText:@"三文鱼1块(200克)、青豆(80克)" withSize:11];
    _material.textAlignment = NSTextAlignmentLeft;
    _material.textColor = UIColorFromRGB(0x505050);
    [self.contentView addSubview:_material];
    UILabel *label3 = [ui initializeLabelWithFrame:CGRectMake(16*kRate, 84*kRate, 79*kRate, 15*kRate) withText:@"辅材：" withSize:11];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.textColor = UIColorFromRGB(0xff5a00);
    [self.contentView addSubview:label3];

    _subMaterial = [ui initializeLabelWithFrame:CGRectMake(16*kRate, 103*kRate, 320*kRate, 14*kRate) withText:@"盐5小勺(5克)、料酒1大勺、食用油10ML、蒜头2瓣(20克)" withSize:11];
    _subMaterial.textAlignment = NSTextAlignmentLeft;
    _subMaterial.textColor = UIColorFromRGB(0x505050);
    [self.contentView addSubview:_subMaterial];
    
}





@end
